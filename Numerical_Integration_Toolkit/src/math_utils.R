# Math utilities for Numerical Integration

# Estimate max|f''(x)| and max|f⁴(x)| numerically
estimate_max_deriv <- function(f, a, b, order = 2) {
  if (a >= b) {
    return(NA)
  } # Invalid interval for differentiation here

  pts <- seq(a, b, length.out = 1000)
  eps <- (b - a) * 1e-4

  if (order == 2) {
    # Central difference for 2nd derivative
    vals <- abs((f(pts + eps) - 2 * f(pts) + f(pts - eps)) / eps^2)
  } else if (order == 4) {
    # Central difference for 4th derivative
    vals <- abs((f(pts + 2 * eps) - 4 * f(pts + eps) + 6 * f(pts) - 4 * f(pts - eps) + f(pts - 2 * eps)) / eps^4)
  } else {
    stop("Derivative estimation only supports order 2 or 4.")
  }

  # Ignore NAs or Inf which can happen at asymptotes
  vals <- vals[is.finite(vals)]
  if (length(vals) == 0) {
    return(NA)
  }

  max(vals)
}

# Wrapper to safely run integrate and handle functions that might hit singularities
get_exact_integral <- function(f, a, b) {
  res <- tryCatch(
    {
      integrate(f, a, b)$value
    },
    error = function(e) {
      warning(sprintf("R integrate() failed: %s. Using NA for Exact value.", e$message))
      NA
    }
  )
  return(res)
}
