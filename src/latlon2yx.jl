"""

N, E = latlon2yx(φ₀::T, λ₀::T, φ::T, λ::T) where T <: Float64

Coordinate transformation between geographic and plane rectangular coordinates on the Gauss-Krüger Projection
This function is based on the following documents:
        https://www.gsi.go.jp/common/000061216.pdf
        https://vldb.gsi.go.jp/sokuchi/surveycalc/surveycalc/algorithm/xy2bl/xy2bl.htm
        https://vldb.gsi.go.jp/sokuchi/surveycalc/surveycalc/algorithm/bl2xy/bl2xy.htm

### input arguments
- φ₀, λ₀ : latitude of origin and central meridian
- φ , λ  : geographic latitude and longitude
### return values
- N, E   : plane rectangular coordinates northing and easting
"""
function latlon2yx(φ₀::T, λ₀::T, φ::T, λ::T) where T <: Float64

    φ₀ = deg2rad(φ₀)
    λ₀ = deg2rad(λ₀)
    φ = deg2rad(φ)
    λ = deg2rad(λ)

    S̅φ₀ = arclength(φ₀)

    ncoef1 = 2sqrt(n)/(1+n)

    t = sinh(atanh(sin(φ)) - ncoef1*atanh(ncoef1*sin(φ)))
    t̅ = sqrt(1+t^2)
    λc = cos(λ-λ₀)
    λs = sin(λ-λ₀)
    ξ′ = atan(t,λc)
    η′ = atanh(λs/t̅)

    # α terms
    αcoef = [1/2   -2/3    5/16        41/180     -127/288; # α₁
             0.0  13/48    -3/5      557/1440      281/630; # α₂
             0.0    0.0  61/240      -103/140  15061/26880; # α₃
             0.0    0.0     0.0  49561/161280     -179/168; # α₄
             0.0    0.0     0.0           0.0  34729/80460; # α₅
            ]
    αj = αcoef * [n^k for k=1:5]

    N = A̅*(ξ′ + sum([αj[j]sin(2j*ξ′)cosh(2j*η′) for j=1:5])) - S̅φ₀
    E = A̅*(η′ + sum([αj[j]cos(2j*ξ′)sinh(2j*η′) for j=1:5]))

    return N, E
end
# -------------------------------------
"""
E, N = lonlat2xy(λ₀::T, φ₀::T, λ::T, φ::T) where T <: Float64

See [`lanlon2yx`](@ref)
"""
lonlat2xy(λ₀::T, φ₀::T, λ::T, φ::T) where T <: Float64 = reverse(latlon2yx(φ₀, λ₀, φ, λ))

# -------------------------------------
function latlon2yx_ja(zone::Int, φ::T, λ::T) where T <: Float64
    if !(0 < zone < 20)
        error("system must be a integer from 1 to 19")
    end
    return latlon2yx(Origin_LatLon_Japan[zone,:]..., φ, λ)
end
# -------------------------------------
lonlat2xy_ja(zone::Int, λ::T, φ::T) where T <: Float64 = reverse(latlon2yx_ja(zone, φ, λ))
# -------------------------------------
