#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

pkgs <- list("shiny","data.table","magrittr","DT", "rjson")
sapply(unlist(pkgs),require, character.only=TRUE)

load(file = "./input_data.Rdata")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("World Bank Data test"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "filtro0",
                    width = "100%" ,
                    label = "País",
                    choices = list(`Mexico`="MEX",
                                `Peru`="PER",
                                `Brasil`="BRA"),
                    multiple = F
        ),
         selectInput(inputId = "filtro1",
                     width = "100%" ,
                     label = "métrica",
                     choices = data_shiny$dict$descripcion,
                     multiple = F
                     )
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         DT::DTOutput("table")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
    output$table <- DT::renderDT({ 
      code <- data_shiny$dict[descripcion == input$filtro1]
      pass <- c("año",code$codigo)
      data_shiny$data[,..pass]
    })
   #    # generate bins based on input$bins from ui.R
   #    x    <- faithful[, 2] 
   #    bins <- seq(min(x), max(x), length.out = input$bins + 1)
   #    
   #    # draw the histogram with the specified number of bins
   #    hist(x, breaks = bins, col = 'darkgray', border = 'white')
   # })
}

# Run the application 
shinyApp(ui = ui, server = server)

