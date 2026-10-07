## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)

## -----------------------------------------------------------------------------
library(spatialcvR)

# Load sample data
data(sample_spatial_data)
head(sample_spatial_data)

## -----------------------------------------------------------------------------
# Create spatial block folds
folds_block <- spatial_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  method = "block",
  seed = 123
)

print(folds_block)

## -----------------------------------------------------------------------------
# Specify block size
folds_block_size <- spatial_block_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  block_size = c(200, 200),  # 200x200 unit blocks
  seed = 123
)

# Specify number of blocks
folds_n_blocks <- spatial_block_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  n_blocks = c(5, 5),  # 5x5 grid
  seed = 123
)

## -----------------------------------------------------------------------------
# Systematic assignment (default)
folds_systematic <- spatial_block_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  assignment = "systematic",
  seed = 123
)

# Random assignment
folds_random_assign <- spatial_block_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  assignment = "random",
  seed = 123
)

## -----------------------------------------------------------------------------
# Create buffered folds
folds_buffer <- spatial_buffer_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  buffer_radius = 100,  # 100 unit buffer
  seed = 123
)

print(folds_buffer)

## -----------------------------------------------------------------------------
# Create clustering folds
folds_cluster <- spatial_cluster_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  n_clusters = 10,  # Number of spatial clusters
  seed = 123
)

print(folds_cluster)

## -----------------------------------------------------------------------------
# Examine cluster centers
folds_cluster$parameters$cluster_centers

## -----------------------------------------------------------------------------
# Create random folds
folds_random <- spatial_split(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  seed = 123
)

print(folds_random)

## -----------------------------------------------------------------------------
# Plot individual fold
plot_spatial_folds(folds_block, sample_spatial_data, "longitude", "latitude", 
                   fold = 1, main = "Block CV - Fold 1")

# Plot all folds
plot_spatial_folds(folds_block, sample_spatial_data, "longitude", "latitude", 
                   fold = "all", main = "Block CV - All Folds")

## -----------------------------------------------------------------------------
# Default spatial block CV
folds_default <- spatial_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5
)

## -----------------------------------------------------------------------------
# Compare spatial vs random
folds_spatial <- spatial_folds(sample_spatial_data, "longitude", "latitude", 
                               k = 5, method = "block", seed = 123)
folds_random <- spatial_folds(sample_spatial_data, "longitude", "latitude", 
                             k = 5, method = "random", seed = 123)

# Analyze spatial leakage for both
leakage_spatial <- detect_spatial_leakage(sample_spatial_data, folds_spatial, 
                                           "longitude", "latitude")
leakage_random <- detect_spatial_leakage(sample_spatial_data, folds_random, 
                                          "longitude", "latitude")

print(leakage_spatial)
print(leakage_random)

## -----------------------------------------------------------------------------
# Reduce number of folds
folds_k3 <- spatial_folds(sample_spatial_data, "longitude", "latitude", k = 3)

