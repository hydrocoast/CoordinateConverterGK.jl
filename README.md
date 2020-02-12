# Coordinate conversion with the Gauss-Krüger Projection

[![Build Status](https://travis-ci.com/hydrocoast/CoordinateConverterGK.jl.svg?branch=master)](https://travis-ci.com/hydrocoast/CoordinateConverterGK.jl)
[![Codecov](https://codecov.io/gh/hydrocoast/CoordinateConverterGK.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/hydrocoast/CoordinateConverterGK.jl)
[![Coveralls](https://coveralls.io/repos/github/hydrocoast/CoordinateConverterGK.jl/badge.svg?branch=master)](https://coveralls.io/github/hydrocoast/CoordinateConverterGK.jl?branch=master)

<p align="center">
<img src="https://github.com/hydrocoast/CoordinateConverterGK.jl/blob/master/examples/samplefig.png", width="800">
</p>  

## Overview
CoordinateConverterGK.jl is a Julia package for conversion between the Cartesian coordinates and the geographic coordinates for a point with the Gauss-Krüger Projection. The formulae are based on documents and publications of [the Geospatial Information Authority of Japan](https://www.gsi.go.jp/ENGLISH/index.html) (see **References**).

<!--
## Installation
You can install the latest version using the built-in package manager (accessed by pressing `]` in the Julia REPL) to add the package.
```julia
pkg> add CoordinateConverterGK
```
-->
## Usage
### General use  
Given a central meridian `λ₀` and latitude of origin `φ₀`, Cartesian coordinates can be converted with the following code:
```julia
using CoordinateConverterGK
λ, φ = xy2lonlat(λ₀, φ₀, easting, northing)
```
where `λ` and `φ` are the converted longitude and latitude, `easting` and `northing` are the eastward and northward distances (in meter) from the origin, respectively.
A function `yx2latlon` is available in the same manner:
```julia
φ, λ = yx2latlon(φ₀, λ₀, northing, easting)
```
Similarly, functions `lonlat2xy` and `latlon2yx` can convert geographic coordinates to Cartesian coordinates for a point.
```julia
x, y = lonlat2xy(λ₀, φ₀, λ, φ)
```

### Japan Plane Rectangular Coordinate System
When the Japan Plane Rectangular Coordinate System is adopted,
functions such as `xy2lonlat_ja` and `lonlat2xy_ja` can omit the coordinates of origin `λ₀`, `φ₀`.
Instead, these functions require the zone number of interest (1 to 19).
```julia
λ, φ = xy2lonlat_ja(9, easting, northing) # in case of zone IX
```


## References
- Kawase, K. (2013) [Concise Derivation of Extensive Coordinate Conversion Formulae in the Gauss-Krüger Projection](https://www.gsi.go.jp/common/000065826.pdf), Bulletin of the Geospatial Information Authority of Japan, **60**, pp.1&ndash;6  

- Kawase, K. (2011) [A More Concise Method of Calculation for the Coordinate Conversion between Geographic and Plane Rectangular Coordinates on the Gauss-Krüger Projection](https://www.gsi.go.jp/common/000061216.pdf) (in Japanese), 国土地理院時報, **121**, pp.109&ndash;124.

- https://vldb.gsi.go.jp/sokuchi/surveycalc/surveycalc/algorithm/bl2xy/bl2xy.htm

- https://vldb.gsi.go.jp/sokuchi/surveycalc/surveycalc/algorithm/xy2bl/xy2bl.htm
