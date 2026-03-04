library(cli)

method_files <- list.files("methods", full.names = TRUE, pattern = "\\.R$")
for (mf in method_files) source(mf)

# Input
args <- commandArgs(trailingOnly = TRUE)
if (length(args) >= 4) {
    expr <- args[1]
    a <- as.numeric(args[2])
    b <- as.numeric(args[3])
    n <- as.integer(args[4])
} else {
    f_in <- file("stdin")
    open(f_in)
    cat("f(x): ")
    expr <- readLines(f_in, 1, warn = FALSE)
    cat("a: ")
    a <- as.numeric(readLines(f_in, 1, warn = FALSE))
    cat("b: ")
    b <- as.numeric(readLines(f_in, 1, warn = FALSE))
    cat("n: ")
    n <- as.integer(readLines(f_in, 1, warn = FALSE))
    close(f_in)
}

f <- function(x) eval(parse(text = expr))

# Run & Display
cli_h1("Numerical Integration")
cat(sprintf("  f(x) = %s | [%g, %g] | n = %d\n\n", expr, a, b, n))
cat(sprintf("  %-15s %-15s %s\n", "Method", "Result", "Time(s)"))
cli_rule()
for (m in tools::file_path_sans_ext(basename(method_files))) {
    start <- Sys.time()
    val <- get(m)(f, a, b, n)
    elapsed <- as.numeric(Sys.time() - start)
    cat(sprintf("  %-15s %-15.6f %.6f\n", m, val, elapsed))
}
cli_rule()
