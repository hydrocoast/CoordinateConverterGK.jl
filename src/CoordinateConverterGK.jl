module CoordinateConverterGK
    include("defconstant.jl")
    include("arclength.jl")
    include("yx2latlon.jl")
    include("latlon2yx.jl")
    export yx2latlon, xy2lonlat
    export yx2latlon_ja, xy2lonlat_ja
    export latlon2yx, lonlat2xy
    export latlon2yx_ja, lonlat2xy_ja
end
