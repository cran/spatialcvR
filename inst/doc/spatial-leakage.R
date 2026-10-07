## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)

## -----------------------------------------------------------------------------
library(spatialcvR)

# Load sample data
data(sample_spatial_data)

# Create spatial folds
folds <- spatial_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  method = "block",
  seed = 123
)

# Detect spatial leakage
leakage <- detect_spatial_leakage(
  data = sample_spatial_data,
  folds = folds,
  x = "longitude",
  y = "latitude"
)

print(leakage)

## -----------------------------------------------------------------------------
# Calculate detailed spatial distances
distances <- spatial_distance(
  data = sample_spatial_data,
  folds = folds,
  x = "longitude",
  y = "latitude"
)

print(distances)

## -----------------------------------------------------------------------------
# Use custom distance threshold
leakage_custom <- detect_spatial_leakage(
  data = sample_spatial_data,
  folds = folds,
  x = "longitude",
  y = "latitude",
  threshold = 50  # 50 unit threshold
)

print(leakage_custom)

## -----------------------------------------------------------------------------
# Define custom risk thresholds
leakage_custom_risk <- detect_spatial_leakage(
  data = sample_spatial_data,
  folds = folds,
  x = "longitude",
  y = "latitude",
  risk_levels = list(
    low = 0.05,      # < 5% below threshold
    moderate = 0.15   # < 15% below threshold
  )
)

print(leakage_custom_risk)

## -----------------------------------------------------------------------------
# Create spatial block folds
folds_spatial <- spatial_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  method = "block",
  seed = 123
)

# Create random folds
folds_random <- spatial_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  method = "random",
  seed = 123
)

# Detect leakage for both
leakage_spatial <- detect_spatial_leakage(
  data = sample_spatial_data,
  folds = folds_spatial,
  x = "longitude",
  y = "latitude"
)

leakage_random <- detect_spatial_leakage(
  data = sample_spatial_data,
  folds = folds_random,
  x = "longitude",
  y = "latitude"
)

# Compare results
cat("Spatial Block CV:\n")
print(leakage_spatial)

cat("\nRandom CV:\n")
print(leakage_random)

## -----------------------------------------------------------------------------
# Simulate high leakage scenario
folds_high_leakage <- spatial_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 10,  # Many folds with small blocks
  method = "block",
  seed = 123
)

leakage_high <- detect_spatial_leakage(
  data = sample_spatial_data,
  folds = folds_high_leakage,
  x = "longitude",
  y = "latitude"
)

print(leakage_high)

## -----------------------------------------------------------------------------
# Simulate low leakage scenario
folds_low_leakage <- spatial_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 3,  # Few folds with large blocks
  method = "block",
  seed = 123
)

leakage_low <- detect_spatial_leakage(
  data = sample_spatial_data,
  folds = folds_low_leakage,
  x = "longitude",
  y = "latitude"
)

print(leakage_low)

## -----------------------------------------------------------------------------
# Solution 1: Increase block size
folds_larger_blocks <- spatial_block_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  block_size = c(300, 300),  # Larger blocks
  seed = 123
)

# Solution 2: Use buffered CV
folds_buffered <- spatial_buffer_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 5,
  buffer_radius = 150,  # Larger buffer
  seed = 123
)

# Solution 3: Reduce number of folds
folds_fewer <- spatial_folds(
  data = sample_spatial_data,
  x = "longitude",
  y = "latitude",
  k = 3,  # Fewer folds
  method = "block",
  seed = 123
)

## -----------------------------------------------------------------------------
# 1. Create folds
folds <- spatial_folds(sample_spatial_data, "longitude", "latitude", 
                      k = 5, method = "block", seed = 123)

# 2. Check for leakage
leakage <- detect_spatial_leakage(sample_spatial_data, folds, 
                                   "longitude", "latitude")

# 3. If high risk, adjust parameters
if (leakage$risk_level == "high") {
  folds <- spatial_folds(sample_spatial_data, "longitude", "latitude",
                        k = 3, method = "block", seed = 123)
}

# 4. Proceed with model training and evaluation
# (Model training code would go here)

## -----------------------------------------------------------------------------
# Warning for geographic coordinates
# (This is automatically triggered by the package)

