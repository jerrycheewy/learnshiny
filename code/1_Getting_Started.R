packageVersion('shiny')
library(shiny)

#1
ui <- fluidPage(
  "testing 1 2 3!"
)
server <- function(input, output, session) {
  
}
shinyApp(ui = ui, server = server)

#2
ui2 <- fluidPage(
  selectInput(inputId = "dataset", label = "Dataset", choices = ls("package:datasets"), selected = "airmiles"), #can include default choice with `selected`
  verbatimTextOutput("summary"),
  tableOutput("table")
)
shinyApp(ui2, server) #Haven't defined how input and output are related so there is not output

#3
server3 <- function(input, output, session) {
  output$summary <- renderPrint({ #all outputs require a render function. Need to choose a suitable render type, eg. renderPrint, renderTable, renderImage
    dataset <- get(x = input$dataset, pos = "package:datasets")
    summary(dataset)
  })
  output$table <- renderTable({
    dataset <- get(x = input$dataset, pos = "package:datasets")
    dataset
  })
}
shinyApp(ui2, server3)

#4 Updating server() to use reactive expressions to retrieve the dataset once.
server4 <- function(input, output, session) {
  dataset <- reactive({
    get(x = input$dataset, "package:datasets")
  })
  output$summary <- renderPrint({
    summary(dataset())
  })
  output$table <- renderTable({
    dataset()
  })
}
shinyApp(ui2, server4)

#Exercise 1
ui_ex <- fluidPage(
  numericInput(inputId = "age", label = "How old are you?", value = NA),
  textInput(inputId = "name", label = "What's your name?", value = NA),
  tableOutput("mortgage"),
  textOutput("greeting"),
  plotOutput("histogram")
)
server_ex <- function(input, output, session){
  output$greeting <- renderText({
    paste0("Hello ", input$name)
  })
  output$histogram <- renderPlot({
    hist(rnorm(1000))
  }, res = 96)
}
shinyApp(ui = ui_ex, server = server_ex)

# ex2
ui_ex2 <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  "then x times 5 is",
  textOutput("product")
)

server_ex2 <- function(input, output, session) {
  output$product <- renderText({ 
    input$x * 5 #need to call on the reactive values in the `input` object
  })
}

shinyApp(ui_ex2, server_ex2)

# ex3
ui_ex3 <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", label = "and y is", min = 1, max = 50, value = 30),
  "then, x times y is",
  textOutput("product")
)

server_ex3 <- function(input, output, session){
  output$product <- renderText({
    input$x * input$y
    })
}
shinyApp(ui_ex3, server_ex3)

# ex4
ui_ex4 <- fluidPage(
  sliderInput("x", "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", "and y is", min = 1, max = 50, value = 5),
  "then, (x * y) is", textOutput("product"),
  "and, (x * y) + 5 is", textOutput("product_plus5"),
  "and (x * y) + 10 is", textOutput("product_plus10")
)

server_ex4 <- function(input, output, session) {
  product <- reactive({input$x * input$y}) #Encapsulate `product` as a reactive object
  
  output$product <- renderText({ 
    #product <- input$x * input$y
    product() #trick is to call on the reactive object saved with the brackets, almost like a function.
  })
  output$product_plus5 <- renderText({ 
    #product <- input$x * input$y
    product() + 5
  })
  output$product_plus10 <- renderText({ 
    #product <- input$x * input$y
    product() + 10
  })
}

shinyApp(ui_ex4, server_ex4)
