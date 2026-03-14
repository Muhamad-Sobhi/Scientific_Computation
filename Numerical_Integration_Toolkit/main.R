source("src/cli.R")
source("src/math_utils.R")
source("src/parser.R")

method_files <- list.files("methods", full.names = TRUE, pattern = "\\.R$")
for (mf in method_files) source(mf)

args <- commandArgs(trailingOnly = TRUE)
inputs <- read_cli_inputs(args)

validate_inputs(inputs$a, inputs$b)

f <- parse_function(inputs$expr)

exact <- get_exact_integral(f, inputs$a, inputs$b)

print_header(inputs$expr, inputs$a, inputs$b, inputs$n)

for (m in tools::file_path_sans_ext(basename(method_files))) {
  if (!exists(m)) next
  method_func <- get(m)

  start_time <- Sys.time()

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
