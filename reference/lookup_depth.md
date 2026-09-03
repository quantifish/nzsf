# Look up GEBCO elevation at specific locations around New Zealand

Look up GEBCO elevation at specific locations around New Zealand

## Usage

``` r
lookup_depth(pts)
```

## Arguments

- pts:

  An sf or sfc object containing point geometries.

## Value

GEBCO elevation, in metres, at each location. Ocean depths are returned
as negative elevations.

## Author

Darcy Webber <darcy@quantifish.co.nz>
