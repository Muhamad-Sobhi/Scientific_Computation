simpson38 <- function(f, a, b, n) {
    if (n %% 3 != 0) n <- n + (3 - n %% 3) # n must be multiple of 3
    h <- (b - a) / n
    x <- seq(a, b, length.out = n + 1)
    y <- f(x)

    idx <- 2:n
    idx_mult3 <- if (n > 3) seq(4, n - 1, by = 3) else integer(0)
    idx_not_mult3 <- setdiff(idx, idx_mult3)

    sum_mult3 <- if (length(idx_mult3) > 0) sum(y[idx_mult3]) else 0
    sum_not_mult3 <- sum(y[idx_not_mult3])

    (3 * h / 8) * (y[1] + y[n + 1] + 3 * sum_not_mult3 + 2 * sum_mult3)
}
