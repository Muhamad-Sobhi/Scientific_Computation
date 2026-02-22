library(shiny)

# --- UI Side ---
ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      body { 
      background-color: #000000; 
      display: flex; 
      justify-content: center; 
      align-items: center; 
      height: 100vh; 
      margin: 0; }
      .calc-container { 
        background-color: #1a1a1a; 
        border-radius: 40px; 
        padding: 25px; 
        width: 340px; 
        box-shadow: 0 20px 50px rgba(0,0,0,0.8);
      }
      .display-screen {
        text-align: right;
        font-size: 55px;
        padding: 20px;
        min-height: 100px;
        color: white;
        font-weight: 300;
        word-wrap: break-word;
      }
      .btn-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 12px;
      }
      .calc-btn {
        border: none;
        border-radius: 25px;
        height: 65px;
        font-size: 22px;
        font-weight: 500;
        transition: all 0.1s;
        cursor: pointer;
        outline: none !important;
      }
      .btn-num { background-color: #262626; color: white; }
      .btn-op { background-color: #33363d; color: #a5c9ff; }
      .btn-equals { background-color: #a5c9ff; color: #1a1a1a; }
      
      .calc-btn:active { transform: scale(0.9); filter: brightness(1.3); }
      .calc-btn:hover { filter: brightness(1.1); }
    "))
  ),
  
  div(class = "calc-container",
      div(class = "display-screen", textOutput("display")),
      
      div(class = "btn-grid",
          actionButton("btn_open", "(", class = "calc-btn btn-op"),
          actionButton("btn_close", ")", class = "calc-btn btn-op"),
          actionButton("btn_perc", "%", class = "calc-btn btn-op"),
          actionButton("btn_AC", "AC", class = "calc-btn btn-op"),
          
          actionButton("btn_7", "7", class = "calc-btn btn-num"),
          actionButton("btn_8", "8", class = "calc-btn btn-num"),
          actionButton("btn_9", "9", class = "calc-btn btn-num"),
          actionButton("btn_div", "÷", class = "calc-btn btn-op"),
          
          actionButton("btn_4", "4", class = "calc-btn btn-num"),
          actionButton("btn_5", "5", class = "calc-btn btn-num"),
          actionButton("btn_6", "6", class = "calc-btn btn-num"),
          actionButton("btn_mult", "×", class = "calc-btn btn-op"),
          
          actionButton("btn_1", "1", class = "calc-btn btn-num"),
          actionButton("btn_2", "2", class = "calc-btn btn-num"),
          actionButton("btn_3", "3", class = "calc-btn btn-num"),
          actionButton("btn_sub", "-", class = "calc-btn btn-op"),
          
          actionButton("btn_0", "0", class = "calc-btn btn-num"),
          actionButton("btn_dot", ".", class = "calc-btn btn-num"),
          actionButton("btn_equal", "=", class = "calc-btn btn-equals"),
          actionButton("btn_add", "+", class = "calc-btn btn-op")
      )
  )
)

# --- Server Side ---
server <- function(input, output, session) {
  # Value to hold the string expression
  v <- reactiveValues(expr = "0", new_op = FALSE)
  
  # Function to handle all inputs
  observe({
    # We use a loop to create observers for all buttons dynamically
    btns <- c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "(", ")", "%")
    
    lapply(btns, function(x) {
      observeEvent(input[[paste0("btn_", x)]], {
        if (v$expr == "0") v$expr <- x
        else v$expr <- paste0(v$expr, x)
      })
    })
  })
  
  # Operators mapping
  observeEvent(input$btn_add, { v$expr <- paste0(v$expr, "+") })
  observeEvent(input$btn_sub, { v$expr <- paste0(v$expr, "-") })
  observeEvent(input$btn_mult, { v$expr <- paste0(v$expr, "*") })
  observeEvent(input$btn_div, { v$expr <- paste0(v$expr, "/") })
  
  # Clear button
  observeEvent(input$btn_AC, { v$expr <- "0" })
  
  # Calculation Logic
  observeEvent(input$btn_equal, {
    tryCatch({
      # eval(parse()) treats the string as R code to calculate it
      result <- eval(parse(text = v$expr))
      v$expr <- as.character(result)
    }, error = function(e) {
      v$expr <- "Error"
    })
  })
  
  output$display <- renderText({ v$expr })
}

shinyApp(ui, server)