monte_carlo <- function(f, a, b, n) {
  # Generate `n` random points uniformly distributed between `a` and `b`
  x_rand <- runif(n, min = a, max = b)

  # Calculate the function values at these random points
  y_rand <- f(x_rand)

  # Average function value multiplied by interval length (b-a)
  value <- (b - a) * mean(y_rand)

  # Error Bound for Monte Carlo: O(1/sqrt(n)), but let's provide the statistical standard error
  # since it's a probabilistic method rather than a deterministic derivative-bound method.
  variance <- var(y_rand) / n
  std_error <- (b - a) * sqrt(variance)

  list(value = value, error_bound = std_error)
}
