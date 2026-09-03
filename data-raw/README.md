# Package data provenance and maintenance

The objects in `data/` are derived data bundled for offline use by `nzsf`.
They should be treated as snapshots, not as live copies of the authoritative
services. Legacy source archives are intentionally excluded from the package
repository, and retrieval dates were not recorded for every historical input.
That limitation is now explicit rather than being inferred from file names.

Authoritative sources include:

- Fisheries New Zealand fisheries maps and QMA layers:
  <https://www.mpi.govt.nz/legal/legislation-standards-and-reviews/fisheries-legislation/maps-of-nz-fisheries>
- Land Information New Zealand hydrographic and topographic layers:
  <https://data.linz.govt.nz/>
- GEBCO gridded bathymetry: <https://www.gebco.net/data_and_products/gridded_bathymetry_data/>
- CCAMLR spatial data: <https://spatial.ccamlr.org/>

## Rebuild and validation

1. Obtain the named source archives and place them in `data-raw/`. Confirm the
   source, licence, version, and retrieval date before replacing a snapshot.
2. Run `data-raw/prepare-data.R` from `data-raw/` for vector layers, and run the
   relevant GEBCO preparation script for raster layers. Shapefiles are extracted
   only into a temporary directory, and geometries are made valid on ingestion.
3. From the package root, run `Rscript data-raw/validate-package-data.R` (the
   script uses the `sf`, `s2`, and `raster` packages). This
   repairs any remaining invalid simple-feature geometries, saves every `.rda`
   file with xz compression, and refreshes `package-data-manifest.csv`.
4. Run the test suite and a full package check. Review maps visually whenever a
   source layer has changed; validity checks do not establish that boundaries
   are scientifically or legally current.

The manifest records each bundled object's file hash, size, class, dimensions,
CRS, and geometry-validity result. A source update should be accompanied by a
NEWS entry explaining the source version and any boundary changes.

## Ling boundary status

The MPI catalogue identifies Ling QMAs as layer 41 of the authoritative QMA
service:
<https://maps.mpi.govt.nz/wss/service/arcgis1/guest/MARINE/MARINE_QMAs/MapServer/41>.
During the 4 September 2026 maintenance pass, the catalogue metadata was
available, but the feature-download endpoint repeatedly reset connections from
both development machines. The bundled eight-feature `LING_QMA` snapshot was
therefore geometry-repaired and validated, but not represented as a newly
retrieved legal boundary. Its alignment with general statistical-area polygons
must not be inferred merely from geometric validity.
