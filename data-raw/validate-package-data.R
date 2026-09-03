library(sf)
library(raster)
library(s2)

make_valid_for_storage <- function(x) {
  validity <- st_is_valid(x)
  if (all(validity %in% TRUE)) return(x)

  invalid <- which(is.na(validity) | !validity)
  repaired <- st_make_valid(st_geometry(x)[invalid])
  if (any(!st_is_valid(repaired))) {
    geography <- s2_geog_from_wkb(
      st_as_binary(repaired),
      check = FALSE
    )
    geography <- s2_rebuild(
      geography,
      options = s2_options(snap = s2_snap_precision(1e6))
    )
    repaired <- st_as_sfc(geography, crs = st_crs(x))
  }
  if (any(!st_is_valid(repaired))) {
    stop("Geometry repair failed.")
  }

  st_geometry(x)[invalid] <- repaired
  geometry_types <- unique(as.character(st_geometry_type(x)))
  if (all(geometry_types %in% c("POLYGON", "MULTIPOLYGON"))) {
    x <- suppressWarnings(st_cast(x, "MULTIPOLYGON"))
  }
  if (any(!st_is_valid(x))) stop("Geometry repair failed after assignment.")
  x
}

source_data_dir <- Sys.getenv("NZSF_SOURCE_DATA_DIR", unset = "data")
source_files <- list.files(source_data_dir, pattern = "[.]rda$", full.names = TRUE)
source_files <- source_files[
  basename(source_files) != "NZBathymetry_2016_grid.rda"
]
records <- vector("list", length(source_files))

for (i in seq_along(source_files)) {
  source_path <- source_files[[i]]
  path <- file.path("data", basename(source_path))
  data_env <- new.env(parent = baseenv())
  object_names <- load(source_path, envir = data_env)
  if (length(object_names) != 1L) {
    stop("Expected exactly one object in ", path, ".")
  }

  for (object_name in object_names) {
    object <- get(object_name, envir = data_env)
    if (inherits(object, "sf")) {
      object <- make_valid_for_storage(object)
      assign(object_name, object, envir = data_env)
    }
  }

  save(
    list = object_names,
    file = path,
    envir = data_env,
    compress = "xz",
    version = 2
  )

  object <- get(object_names[[1]], envir = data_env)
  is_sf <- inherits(object, "sf")
  is_raster <- inherits(object, "Raster")
  object_crs <- if (is_sf) {
    crs <- st_crs(object)
    if (!is.na(crs$epsg)) paste0("EPSG:", crs$epsg) else crs$input
  } else if (is_raster) {
    as.character(raster::crs(object))
  } else {
    NA_character_
  }

  records[[i]] <- data.frame(
    file = basename(path),
    object = paste(object_names, collapse = ";"),
    md5 = unname(tools::md5sum(path)),
    bytes = file.info(path)$size,
    class = paste(class(object), collapse = ";"),
    features = if (is_sf) nrow(object) else if (is_raster) ncell(object) else length(object),
    attributes = if (is_sf) ncol(object) - 1L else if (is_raster) nlayers(object) else NA_integer_,
    crs = object_crs,
    all_valid = if (is_sf) all(st_is_valid(object)) else NA,
    stringsAsFactors = FALSE
  )
}

manifest <- do.call(rbind, records)
manifest <- manifest[order(manifest$file), ]
write.csv(manifest, "data-raw/package-data-manifest.csv", row.names = FALSE,
          na = "")

stopifnot(
  all(nzchar(manifest$crs)),
  all(manifest$all_valid[!is.na(manifest$all_valid)])
)
