trapezoidal <- function(f, a, b, n) {
  h <- (b - a) / n
  x <- seq(a, b, length.out = n + 1)
  y <- sapply(x, f)
  value <- (h / 2) * (y[1] + 2 * sum(y[2:(n)]) + y[n + 1])

  second_deriv <- sapply(x[2:n], function(xi) {
    (f(xi + h) - 2 * f(xi) + f(xi - h)) / h^2
  })
  max_second_deriv <- max(abs(second_deriv))
  error_bound <- ((b - a)^3 / (12 * n^2)) * max_second_deriv

  list(value = value, error_bound = error_bound)
}
