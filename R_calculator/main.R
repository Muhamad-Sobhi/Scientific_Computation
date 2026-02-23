library(shiny)

addResourcePath(prefix = 'myassets', directoryPath = getwd())

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      body { 
        background: url('myassets/Team-logo.jpeg') no-repeat center fixed; 
        background-size: cover; 
      }
      .calc-box { 
        background: rgba(26, 26, 26, 0.85); 
        border-radius: 35px; 
        padding: 25px; 
        width: 320px; 
        margin: auto; 
        margin-top: 80px; 
        backdrop-filter: blur(15px); 
        box-shadow: 0 20px 50px rgba(0,0,0,0.6);
      }
    "))
  ),
  
  div(class = "calc-box",
      div(style = "text-align: right; font-size: 55px; padding: 20px; color: white;", textOutput("display")),
      
      fluidRow(
        column(6, actionButton("btn_AC", "AC", style = "width:100%; height:60px; border-radius:30px; border:none; background:#a5a5a5; color:black; font-size:20px; margin-bottom:12px;")),
        column(3, actionButton("btn_perc", "%", style = "width:100%; height:60px; border-radius:50%; border:none; background:#33363d; color:#a5c9ff; font-size:22px;")),
        column(3, actionButton("btn_div", "÷", style = "width:100%; height:60px; border-radius:50%; border:none; background:#33363d; color:#a5c9ff; font-size:22px;"))
      ),
      
      fluidRow(
        column(3, actionButton("btn_7", "7", style = "width:100%; height:60px; border-radius:50%; border:none; background:#262626; color:white; font-size:22px; margin-bottom:12px;")),
        column(3, actionButton("btn_8", "8", style = "width:100%; height:60px; border-radius:50%; border:none; background:#262626; color:white; font-size:22px;")),
        column(3, actionButton("btn_9", "9", style = "width:100%; height:60px; border-radius:50%; border:none; background:#262626; color:white; font-size:22px;")),
        column(3, actionButton("btn_mult", "×", style = "width:100%; height:60px; border-radius:50%; border:none; background:#33363d; color:#a5c9ff; font-size:22px;"))
      ),
      
      fluidRow(
        column(3, actionButton("btn_4", "4", style = "width:100%; height:60px; border-radius:50%; border:none; background:#262626; color:white; font-size:22px; margin-bottom:12px;")),
        column(3, actionButton("btn_5", "5", style = "width:100%; height:60px; border-radius:50%; border:none; background:#262626; color:white; font-size:22px;")),
        column(3, actionButton("btn_6", "6", style = "width:100%; height:60px; border-radius:50%; border:none; background:#262626; color:white; font-size:22px;")),
        column(3, actionButton("btn_sub", "-", style = "width:100%; height:60px; border-radius:50%; border:none; background:#33363d; color:#a5c9ff; font-size:22px;"))
      ),
      
      fluidRow(
        column(3, actionButton("btn_1", "1", style = "width:100%; height:60px; border-radius:50%; border:none; background:#262626; color:white; font-size:22px; margin-bottom:12px;")),
        column(3, actionButton("btn_2", "2", style = "width:100%; height:60px; border-radius:50%; border:none; background:#262626; color:white; font-size:22px;")),
        column(3, actionButton("btn_3", "3", style = "width:100%; height:60px; border-radius:50%; border:none; background:#262626; color:white; font-size:22px;")),
        column(3, actionButton("btn_add", "+", style = "width:100%; height:60px; border-radius:50%; border:none; background:#33363d; color:#a5c9ff; font-size:22px;"))
      ),
      
      fluidRow(
        column(6, actionButton("btn_0", "0", style = "width:100%; height:60px; border-radius:30px; border:none; background:#262626; color:white; font-size:22px;")),
        column(3, actionButton("btn_dot", ".", style = "width:100%; height:60px; border-radius:50%; border:none; background:#262626; color:white; font-size:22px;")),
        column(3, actionButton("btn_equal", "=", style = "width:100%; height:60px; border-radius:50%; border:none; background:#a5c9ff; color:#1a1a1a; font-size:22px;"))
      )
  )
)

server <- function(input, output, session) {
  v <- reactiveValues(expr = "0")
  
  add_to_expr <- function(val) {
    if (v$expr == "0") v$expr <- val
    else v$expr <- paste0(v$expr, val)
  }
  
  observeEvent(input$btn_0, { add_to_expr("0") })
  observeEvent(input$btn_1, { add_to_expr("1") })
  observeEvent(input$btn_2, { add_to_expr("2") })
  observeEvent(input$btn_3, { add_to_expr("3") })
  observeEvent(input$btn_4, { add_to_expr("4") })
  observeEvent(input$btn_5, { add_to_expr("5") })
  observeEvent(input$btn_6, { add_to_expr("6") })
  observeEvent(input$btn_7, { add_to_expr("7") })
  observeEvent(input$btn_8, { add_to_expr("8") })
  observeEvent(input$btn_9, { add_to_expr("9") })
  observeEvent(input$btn_dot, { add_to_expr(".") })
  observeEvent(input$btn_add, { add_to_expr("+") })
  observeEvent(input$btn_sub, { add_to_expr("-") })
  observeEvent(input$btn_mult, { add_to_expr("*") })
  observeEvent(input$btn_div, { add_to_expr("/") })
  
  observeEvent(input$btn_perc, { add_to_expr("%%") })
  
  observeEvent(input$btn_AC, { v$expr <- "0" })
  
  observeEvent(input$btn_equal, {
    tryCatch({
      v$expr <- as.character(eval(parse(text = v$expr)))
    }, error = function(e) { v$expr <- "Error" })
  })
  
  output$display <- renderText({ v$expr })
}

shinyApp(ui, server)