function arclength(φ₀)
# A terms
    Acoef =  [  -3/2*[ 1.0  0.0  -1/8      0.0      -1/64]; # A₁
               15/16*[ 0.0  1.0   0.0     -1/4        0.0]; # A₂
              -35/48*[ 0.0  0.0   1.0      0.0      -5/16]; # A₃
                     [ 0.0  0.0   0.0  315/512        0.0]; # A₄
                     [ 0.0  0.0   0.0      0.0  -693/1280]; # A₅
             ]
    Aj = Acoef * [n^k for k=1:5]

    ΣA = sum([Aj[j]*sin(2j*φ₀) for j=1:5])
    S̅φ₀ = (m₀*a)/(1+n) * (A₀*φ₀ + ΣA)

    return S̅φ₀
end
