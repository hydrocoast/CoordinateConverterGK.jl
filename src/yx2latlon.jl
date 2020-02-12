"""

φ , λ = yx2latlon(φ₀::T, λ₀::T, N::T, E::T) where T <: Float64

Coordinate transformation between geographic and plane rectangular coordinates on the Gauss-Krüger Projection
This function is based on the following documents:
        https://www.gsi.go.jp/common/000061216.pdf
        https://vldb.gsi.go.jp/sokuchi/surveycalc/surveycalc/algorithm/xy2bl/xy2bl.htm
        https://vldb.gsi.go.jp/sokuchi/surveycalc/surveycalc/algorithm/bl2xy/bl2xy.htm

### input arguments
- φ₀, λ₀ : latitude of origin and central meridian
- N, E   : plane rectangular coordinates northing and easting
### return values
- φ , λ  : geographic latitude and longitude

### Examples
```julia-repl
julia> # ANSWER: lat = 36.10404755, lon = 140.08539843

julia> yx2latlon(36.0, 139.83333333, 11573.375, 22694.980)
(36.104047552508895, 140.08539842726532)
```

"""
function yx2latlon(φ₀::T, λ₀::T, N::T, E::T) where T <: Float64

    S̅φ₀ = arclength(deg2rad(φ₀))

    # ξ and η
    ξ = (N + S̅φ₀)/A̅
    η = E/A̅


    # β terms
    βcoef = [1/2  -2/3   37/96       -1/360      -81/512; # β₁
             0.0  1/48    1/15    -437/1440       46/105; # β₂
             0.0   0.0  17/480      -37/840    -209/4480; # β₃
             0.0   0.0     0.0  4397/161280      -11/504; # β₄
             0.0   0.0     0.0          0.0  4583/161280; # β₅
            ]
    βj = βcoef * [n^k for k=1:5]

    ξ′ = ξ - sum([βj[j]sin(2j*ξ)cosh(2j*η) for j=1:5])
    η′ = η - sum([βj[j]cos(2j*ξ)sinh(2j*η) for j=1:5])

    # χ
    χ = asin(sin(ξ′)/cosh(η′))

    # δ terms
    δcoef = [2.0 -2/3  -2.0    116/45     26/45     -2854/675; # δ₁
             0.0  7/3  -8/5   -227/45  2704/315      2323/945; # δ₂
             0.0  0.0 56/15   -136/35 -1262/105    73814/2835; # δ₃
             0.0  0.0   0.0  4279/630   -332/35 -339572/14175; # δ₄
             0.0  0.0   0.0       0.0  4174/315  -144838/6237; # δ₅
             0.0  0.0   0.0       0.0       0.0  601676/22275; # δ₆
            ]
    δj = δcoef * [n^k for k=1:6]

    φ = rad2deg( χ + sum([δj[j]sin(2j*χ) for j=1:6]) )
    λ = λ₀ + rad2deg( atan(sinh(η′),cos(ξ′)) )

    #=
    σ′ = 1 - sum([2j*βj[j]*cos(2j*ξ)*cosh(2j*η) for j=1:5])
    τ′ =     sum([2j*βj[j]*sin(2j*ξ)*sinh(2j*η) for j=1:5])
    γ = atan(τ′+σ′*tan(ξ′)tanh(η′), σ′-τ′*tan(ξ′)tanh(η′))
    m = m₀*A₀*(1/(1+n))*sqrt( (cos(ξ′)^2+sinh(η′)^2)/(σ′^2+τ′^2) * (1+((1-n)tan(φ)/(1+n))^2) )
    =#

    return φ, λ
end
# -------------------------------------
"""
λ, φ = xy2lonlat(λ₀::T, φ₀::T, E::T, N::T) where T <: Float64

See [`yx2latlon`](@ref)
"""
xy2lonlat(λ₀::T, φ₀::T, E::T, N::T) where T <: Float64 = reverse(yx2latlon(φ₀, λ₀, N, E))
# -------------------------------------
function yx2latlon_ja(zone::Int, N::T, E::T) where T <: Float64
    if !(0 < zone < 20)
        error("system must be a integer from 1 to 19")
    end
    return yx2latlon(Origin_LatLon_Japan[zone,:]..., N, E)
end
# -------------------------------------
xy2lonlat_ja(zone::Int, E::T, N::T) where T <: Float64 = reverse(yx2latlon_ja(zone, N, E))
# -------------------------------------
