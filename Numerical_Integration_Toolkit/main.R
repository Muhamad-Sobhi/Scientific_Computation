#!/usr/bin/env Rscript

# Load external scripts safely
source("src/cli.R")
source("src/math_utils.R")
source("src/parser.R")

# Load all methods from the 'methods' directory
method_files <- list.files("methods", full.names = TRUE, pattern = "\\.R$")
for (mf in method_files) source(mf)

# 1. Handle Input (Interactive or Args)
args <- commandArgs(trailingOnly = TRUE)
inputs <- read_cli_inputs(args)

# Validate logical limits
validate_inputs(inputs$a, inputs$b)

# 2. Parse Math Expression
f <- parse_function(inputs$expr)

# 3. Calculate Exact Answer
exact <- get_exact_integral(f, inputs$a, inputs$b)

# 4. Run & Display
print_header(inputs$expr, inputs$a, inputs$b, inputs$n)

for (m in tools::file_path_sans_ext(basename(method_files))) {
  if (!exists(m)) next
  method_func <- get(m)

  start_time <- Sys.time()

  # Run the integration algorithm
  res <- tryCatch(
    method_func(f, inputs$a, inputs$b, inputs$n),
    error = function(e) {
      cli::cli_alert_danger(sprintf("Method '%s' failed: %s", m, e$message))
      return(NULL)
    }
  )

  if (!is.null(res)) {
    elapsed <- as.numeric(Sys.time() - start_time)
    print_result_row(m, res, exact, elapsed)
  }
}

print_footer(exact)
