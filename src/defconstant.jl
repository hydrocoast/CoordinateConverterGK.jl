# constants
const a = 6.378137e6 # the semi-major axis of the earth
const F = 298.257222101 # the inverse 1st flattening
const n = 1/(2F-1)
const m₀ = 0.9999 # central meridian scale factor
A₀ = 1 + n^2/4 + n^4/64
const A̅ = A₀/(1+n) *m₀*a


## longitude, latitude of origin for zones in Japan
Origin_LatLon_Japan = [ 33.0  129.5    ; # 1
                        33.0  131.0    ; # 2
                        36.0  132.0+1/6; # 3
                        33.0  133.5    ; # 4
                        36.0  134.0+1/3; # 5
                        36.0  136.0    ; # 6
                        36.0  137.0+1/6; # 7
                        36.0  138.5    ; # 8
                        36.0  139.0+5/6; # 9
                        40.0  140.0+5/6; # 10
                        44.0  140.25   ; # 11
                        44.0  142.25   ; # 12
                        44.0  144.25   ; # 13
                        26.0  142.0    ; # 14
                        26.0  127.5    ; # 15
                        26.0  124.0    ; # 16
                        26.0  131.0    ; # 17
                        20.0  136.0    ; # 18
                        26.0  154.0    ; # 19
                       ]
