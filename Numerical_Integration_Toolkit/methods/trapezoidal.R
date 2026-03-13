trapezoidal <- function(f, a, b, n) {
  h <- (b - a) / n
  x <- seq(a, b, length.out = n + 1)
  y <- f(x)

  sum_middle <- if (n > 1) sum(y[2:n]) else 0
  value <- (h / 2) * (y[1] + 2 * sum_middle + y[n + 1])

  # Error Bound: (b-a)^3 / (12n^2) * max|f''(x)|
  max_f2 <- estimate_max_deriv(f, a, b, 2)
  bound <- if (!is.na(max_f2)) (b - a)^3 / (12 * n^2) * max_f2 else NA

  list(value = value, error_bound = bound)
}
