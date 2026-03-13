# Parser utility for securely and cleanly evaluating math expressions
parse_function <- function(expr_string) {
    # Attempt to parse to catch obvious syntax errors early
    tryCatch(
        {
            parse(text = expr_string)
        },
        error = function(e) {
            stop(sprintf("Invalid mathematical expression: '%s'. Error: %s", expr_string, e$message))
        }
    )

    # Return the evaluated function
    f <- function(x) {
        # Using eval safely in the function scope with mathematical constants
        tryCatch(
            {
                eval(parse(text = expr_string), envir = list(x = x, e = exp(1)))
            },
            error = function(err) {
                stop(sprintf("Failed to evaluate function at x=%g: %s", x[1], err$message))
            }
        )
    }
    return(f)
}
