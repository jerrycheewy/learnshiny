library(shiny)
# Lesson 2 talks about all the kinds of input

#Input ----
#1 Slider ------------
ui <- fluidPage(
  sliderInput("min", "Limit (minimum)", value = 50, min = 0, max = 100, step = 25)
)
server <- function(input, output, session) {
}
shinyApp(ui = ui, server = server)

#2 Text --------------
ui <- fluidPage(
  textInput("name", "What's your name?"),
  passwordInput("password", "What's your password?"),
  textAreaInput("story", "Tell me about yourself", rows = 3)
)
shinyApp(ui = ui, server = server)

#3 Numeric ---------
ui <- fluidPage(
  numericInput("num", "Number one", value = 0, min = 0, max = 100),
  sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
  sliderInput("num3", "Number three", value = 50, min = 0, max = 100, animate = TRUE),
  sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100) #Notice that the value provided is length-2, introducing a slider with two ends.
)
shinyApp(ui, server)

#4 Dates ------------
ui <- fluidPage(
  dateInput("dob", "When were you born?"),
  dateRangeInput("holiday", "When do you want to go on holiday?", format = "dd-mm-yyyy") #This opens up a calendar! with a start and end date!
)
shinyApp(ui, server)

#5 Limited choices ----------
animals <- c("dog", "cat", "bird", "dinosaur")
ui <- fluidPage(
  selectInput("drop", "Select your single favourite animal", choices = animals),
  selectInput("drop_multi", "Select your favourite animals", choices = animals, multiple = TRUE),
  radioButtons("radio", "Select your single favourite animal again!", choices = animals)
)
shinyApp(ui, server)

#6 Checkboxes
ui <- fluidPage(
  checkboxInput("check", "Yes?", value = TRUE),
  checkboxInput("check2", "No?", value = FALSE),
  # Checkbox list! This is because there's no multiple option for radio buttons
  checkboxGroupInput("checklist", "Choose your favourite animals", choices = animals)
)
shinyApp(ui, server)

#7 File uploads ----------
ui <- fluidPage(
  fileInput("upload", "Upload your photo here!", placeholder = "Pls click to upload something")
)
shinyApp(ui, server)

#9 Action buttons ----------
ui <- fluidPage(
  actionButton("click1", "click me!"),
  actionButton("click2", "eject CD!", icon = icon("eject")),
  actionButton("click3", "bigger button", class = "btn-lg btn-danger"), #red
  actionButton("click4", "smaller button", class = "btn-xs btn-success"), #green
  actionButton("click5", "info button", class = "btn-info") #teal
)
shinyApp(ui, server)

# Input Exercises ------------

# Help text inside the text input box
ui <- fluidPage(
  textInput("text", "Key something", placeholder = "You have more space here, provide the context in this location!", width = "100%")
)
shinyApp(ui, server)

# Date slider
ui <- fluidPage(
  sliderInput("date", "Next meeting?", value = lubridate::ymd(20220215), min = lubridate::ymd(20220101), max = lubridate::ymd(20220331))
)
shinyApp(ui, server)

# Number slider with 5 step
ui <- fluidPage(
  sliderInput("slider", "Moving numbers~~", value = 10, min = 0, max = 100, step = 5, animate = TRUE)
)
shinyApp(ui, server)

# Select input list with sub groups
ui <- fluidPage(
  selectInput("sublist", "Favourite food", choices = list("Japanese" = list("Sushi", "Udon"),
                                                          "Western" = list("Fish and chips", "Steak")
                                                          )
              )
)
shinyApp(ui, server)

#Ouput -------------
