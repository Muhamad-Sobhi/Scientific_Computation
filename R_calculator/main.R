library(shiny)

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  div(
    class = "calc-box",
    div(class = "display-screen", textOutput("display")),
    fluidRow(
      class = "compact-row",
      column(3, actionButton("btn_AC", "AC", class = "btn-style btn-action")),
      column(3, actionButton("btn_del", "⌫", class = "btn-style btn-action")),
      column(3, actionButton("btn_open", "(", class = "btn-style btn-op")),
      column(3, actionButton("btn_close", ")", class = "btn-style btn-op"))
    ),
    fluidRow(
      class = "compact-row",
      column(3, actionButton("btn_log", "log(x,b)", class = "btn-style btn-op small-text")),
      column(3, actionButton("btn_comma", ",", class = "btn-style btn-op")),
      column(3, actionButton("btn_perc", "%", class = "btn-style btn-op")),
      column(3, actionButton("btn_div", "÷", class = "btn-style btn-op"))
    ),
    fluidRow(
      class = "compact-row",
      column(3, actionButton("btn_7", "7", class = "btn-style btn-num")),
      column(3, actionButton("btn_8", "8", class = "btn-style btn-num")),
      column(3, actionButton("btn_9", "9", class = "btn-style btn-num")),
      column(3, actionButton("btn_mult", "×", class = "btn-style btn-op"))
    ),
    fluidRow(
      class = "compact-row",
      column(3, actionButton("btn_4", "4", class = "btn-style btn-num")),
      column(3, actionButton("btn_5", "5", class = "btn-style btn-num")),
      column(3, actionButton("btn_6", "6", class = "btn-style btn-num")),
      column(3, actionButton("btn_sub", "-", class = "btn-style btn-op"))
    ),
    fluidRow(
      class = "compact-row",
      column(3, actionButton("btn_1", "1", class = "btn-style btn-num")),
      column(3, actionButton("btn_2", "2", class = "btn-style btn-num")),
      column(3, actionButton("btn_3", "3", class = "btn-style btn-num")),
      column(3, actionButton("btn_add", "+", class = "btn-style btn-op"))
    ),
    fluidRow(
      class = "compact-row",
      column(6, actionButton("btn_0", "0", class = "btn-style btn-num")),
      column(3, actionButton("btn_dot", ".", class = "btn-style btn-num")),
      column(3, actionButton("btn_equal", "=", class = "btn-style btn-equal"))
    )
  )
)

server <- function(input, output, session) {
  v <- reactiveValues(expr = "0")

  add_to_expr <- function(val) {
    if (v$expr == "0" || v$expr == "Error") {
      v$expr <- val
    } else {
      v$expr <- paste0(v$expr, val)
    }
  }

  observeEvent(input$btn_0, {add_to_expr("0")})
  observeEvent(input$btn_1, {add_to_expr("1")})
  observeEvent(input$btn_2, {add_to_expr("2")})
  observeEvent(input$btn_3, {add_to_expr("3")})
  observeEvent(input$btn_4, {add_to_expr("4")})
  observeEvent(input$btn_5, {add_to_expr("5")})
  observeEvent(input$btn_6, {add_to_expr("6")})
  observeEvent(input$btn_7, {add_to_expr("7")})
  observeEvent(input$btn_8, {add_to_expr("8")})
  observeEvent(input$btn_9, {add_to_expr("9")})
  observeEvent(input$btn_dot, {add_to_expr(".")})
  observeEvent(input$btn_comma, {add_to_expr(",")})
  observeEvent(input$btn_open, {add_to_expr("(")})
  observeEvent(input$btn_close, {add_to_expr(")")})
  observeEvent(input$btn_add, {add_to_expr("+")})
  observeEvent(input$btn_sub, {add_to_expr("-")})
  observeEvent(input$btn_mult, {add_to_expr("*")})
  observeEvent(input$btn_div, {add_to_expr("/")})
  observeEvent(input$btn_perc, {add_to_expr("%%")})
  observeEvent(input$btn_AC, {v$expr <- "0"})
  
  observeEvent(input$btn_log, {
    if (v$expr == "0") {
      v$expr <- "log("
    } else {
      v$expr <- paste0(v$expr, "log(")
    }
  })

  observeEvent(input$btn_equal, {
    tryCatch(
      {
        res <- eval(parse(text = v$expr))
        v$expr <- as.character(res)
      },
      error = function(e) {
        v$expr <- "Error"
      }
    )
  })

  observeEvent(input$btn_del, {
    if (nchar(v$expr) > 1) {
      v$expr <- substr(v$expr, 1, nchar(v$expr) - 1)
    } else {
      v$expr <- "0"
    }
  })
  
  output$display <- renderText({v$expr})
}

shinyApp(ui, server)
