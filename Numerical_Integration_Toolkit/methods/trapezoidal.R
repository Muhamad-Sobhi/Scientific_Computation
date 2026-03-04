trapezoidal <- function(f, a, b, n) {
    h <- (b - a) / n
    x <- seq(a, b, length.out = n + 1)
    y <- f(x)

    sum_middle <- if (n > 1) sum(y[2:n]) else 0

    (h / 2) * (y[1] + 2 * sum_middle + y[n + 1])
}
