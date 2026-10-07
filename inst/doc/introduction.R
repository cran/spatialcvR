## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)

## -----------------------------------------------------------------------------
# Example: What happens with random CV on spatial data
set.seed(123)
n <- 100
x <- runif(n, 0, 100)
y <- runif(n, 0, 100)
z <- 10 + 0.5*x + 0.3*y + rnorm(n, 0, 2)  # Spatially structured variable

# Random CV might put nearby points in both train and test
train_idx <- sample(1:n, 80)
test_idx <- setdiff(1:n, train_idx)

# Calculate minimum distance between train and test
distances <- numeric(length(test_idx))
for (i in seq_along(test_idx)) {
  distances[i] <- min(sqrt((x[test_idx[i]] - x[train_idx])^2 + 
                          (y[test_idx[i]] - y[train_idx])^2))
}
min(distances)  # Often very small!

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
  method = "block"
)

# Examine the folds
print(folds)

# Detect spatial leakage
leakage <- detect_spatial_leakage(
  data = sample_spatial_data,
  folds = folds,
  x = "longitude",
  y = "latitude"
)

print(leakage)

