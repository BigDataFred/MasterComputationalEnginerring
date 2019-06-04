#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application
ui <- fluidPage(
  shinyUI(
    basicPage(
      actionButton("play", "Play the Audio")
    )
  )
)

# Define server logic required
server <- shinyServer(function(input, output) {
  observeEvent(input$play, {
    insertUI(selector = "#play",
             where = "afterEnd",
             ui = tags$audio(src = "www/sound.wav", type = "audio/wav", 
                             autoplay = NA, controls = NA, style="display:none;")  
    )
  })
})

# Run the application 
shinyApp(ui = ui, server = server, options = list(height = 500))