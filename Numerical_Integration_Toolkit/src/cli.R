# CLI handling and interactive prompts
library(cli)

read_cli_inputs <- function(args) {
    if (length(args) > 0) {
        # Direct CLI mode
        expr <- args[1]

        a <- if (length(args) >= 2) {
            tryCatch(eval(parse(text = args[2])), error = function(e) stop("Invalid lower bound 'a'"))
        } else {
            0
        }

        b <- if (length(args) >= 3) {
            tryCatch(eval(parse(text = args[3])), error = function(e) stop("Invalid upper bound 'b'"))
        } else {
            1
        }

        n <- if (length(args) >= 4) {
            suppressWarnings(as.integer(args[4]))
        } else {
            100
        }

        if (is.na(n) || n <= 0) stop("Number of partitions 'n' must be a positive integer.")
        return(list(expr = expr, a = a, b = b, n = n))
    }

    # Interactive mode
    f_in <- file("stdin")
    on.exit(close(f_in))

    cli_h2("Input Parameters")

    cat("  Function f(x) (e.g. x^2 + 2*x): ")
    expr <- readLines(f_in, 1, warn = FALSE)
    if (length(expr) == 0 || trimws(expr) == "") stop("Please enter a valid function.")

    cat("  Lower bound [a] (default 0): ")
    a_str <- readLines(f_in, 1, warn = FALSE)
    a <- if (length(a_str) == 0 || trimws(a_str) == "") 0 else tryCatch(eval(parse(text = a_str)), error = function(e) stop("Invalid lower bound 'a'"))

    cat("  Upper bound [b] (default 1): ")
    b_str <- readLines(f_in, 1, warn = FALSE)
    b <- if (length(b_str) == 0 || trimws(b_str) == "") 1 else tryCatch(eval(parse(text = b_str)), error = function(e) stop("Invalid upper bound 'b'"))

    cat("  Number of partitions [n] (default 100): ")
    n_str <- readLines(f_in, 1, warn = FALSE)
    n <- if (length(n_str) == 0 || trimws(n_str) == "") 100 else suppressWarnings(as.integer(n_str))
    if (is.na(n) || n <= 0) stop("Number of partitions 'n' must be a positive integer.")

    return(list(expr = expr, a = a, b = b, n = n))
}

validate_inputs <- function(a, b) {
    if (a >= b) {
        cli_alert_warning("Warning: Lower bound (a) is >= Upper bound (b). Calculating reverse integral.")
    }
}

print_header <- function(expr, a, b, n) {
    cat("\n")
    cli_h1("{.bg-cyan  Numerical Integration Toolkit }")
    cli_text("{.strong Function:} {.val {expr}}  |  {.strong Interval:} [{.val {a}}, {.val {b}}]  |  {.strong Subintervals (n):} {.val {n}}")
    cat("\n")

    # Styled Table Header - apply color AFTER spacing to avoid ANSI length issues
    str_meth <- sprintf("%-15s", "Method")
    str_tim <- sprintf("%-15s", "Time(s)")
    str_res <- sprintf("%-15s", "Result")
    str_act <- sprintf("%-15s", "Actual Err")
    str_bnd <- "Bound Err"

    cat(
        "  ", col_cyan(style_bold(str_meth)), col_blue(style_bold(str_tim)),
        col_green(style_bold(str_res)), col_yellow(style_bold(str_act)),
        col_magenta(style_bold(str_bnd)), "\n"
    )
    cli_rule()
}

print_result_row <- function(method_name, result_list, exact_val, elapsed) {
    val <- result_list$value
    bound <- result_list$error_bound

    act_err <- if (!is.na(exact_val)) abs(val - exact_val) else NA

    act_str <- if (is.na(act_err)) "NA" else sprintf("%.8f", act_err)
    bnd_str <- if (is.na(bound)) "NA" else sprintf("%.8f", bound)

    # Format spaces BEFORE applying colors
    s_meth <- sprintf("%-15s", method_name)
    s_tim <- sprintf("%-15.6f", elapsed)
    s_res <- sprintf("%-15.6f", val)
    s_act <- sprintf("%-15s", act_str)
    s_bnd <- sprintf("%-15s", bnd_str)

    cat(
        "  ", col_cyan(style_bold(s_meth)), col_blue(s_tim),
        col_green(s_res), col_yellow(s_act), col_magenta(s_bnd), "\n"
    )
}

print_footer <- function(exact) {
    cli_rule()
    if (!is.na(exact)) {
        cli_alert_success("{.strong Exact (R integrate):} {.val {sprintf('%.6f', exact)}}")
    } else {
        cli_alert_warning("Exact integral could not be determined.")
    }
    cat("\n")
}
