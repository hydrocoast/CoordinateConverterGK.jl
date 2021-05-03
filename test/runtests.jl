using CoordinateConverterGK
using Test

@testset "CoordinateConverterGK.jl" begin
    # Write your own tests here.

    # xy to lonlat
    northing = 11573.375
    easting = 22694.980
    φ, λ = yx2latlon_ja(9, northing, easting)
    @test (abs(φ - 36.10404755) < 1e-4) & (abs(λ - 140.08539843) < 1e-4)
    λ, φ = xy2lonlat(reverse(CoordinateConverterGK.Origin_LatLon_Japan[9,:])..., easting, northing)
    @test (abs(φ - 36.10404755) < 1e-4) & (abs(λ - 140.08539843) < 1e-4)

    # lonlat to xy
    lat = 36.103774791666666
    lon = 140.08785504166664
    y, x = latlon2yx_ja(9, lat, lon)
    @test (abs(y - 11543.6883) < 1e-4) & (abs(x - 22916.2436) < 1e-4)
    λ, φ = lonlat2xy(reverse(CoordinateConverterGK.Origin_LatLon_Japan[9,:])..., lon, lat)
    @test (abs(y - 11543.6883) < 1e-4) & (abs(x - 22916.2436) < 1e-4)

    # args in reverse order
    @test yx2latlon_ja(9, northing, easting) == reverse(xy2lonlat_ja(9, easting, northing))
    @test latlon2yx_ja(9, lat, lon) == reverse(lonlat2xy_ja(9, lon, lat))
end
