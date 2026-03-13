simpson13 <- function(f, a, b, n) {
  if (n %% 2 != 0) n <- n + 1
  h <- (b - a) / n
  x <- seq(a, b, length.out = n + 1)
  y <- f(x)

  sum_odd <- sum(y[seq(2, n, by = 2)])
  sum_even <- if (n > 2) sum(y[seq(3, n - 1, by = 2)]) else 0
  value <- (h / 3) * (y[1] + y[n + 1] + 4 * sum_odd + 2 * sum_even)

  # Error Bound: (b-a)^5 / (180n^4) * max|f''''(x)|
  max_f4 <- estimate_max_deriv(f, a, b, 4)
  bound <- if (!is.na(max_f4)) (b - a)^5 / (180 * n^4) * max_f4 else NA

  list(value = value, error_bound = bound)
}
