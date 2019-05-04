library(shiny)
library(ggplot2)

ui<-fluidPage(
  titlePanel("The APP"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("initialamount", "Intial Amount:",
                  min = 0, max = 100000, value = 1000, step = 500),
      sliderInput("annualcontribution", "Annual Contribution:",
                  min=0, max = 50000, value = 2000, step = 500),
      sliderInput("return rate", "Return Rat:",
                  min=0, max=0.20, value=0.05, step=0.001),
      sliderInput("growthrate", "Growth Rate:",
                  min=0, max = 0.2, value = 0.02, step = 0.001),
      sliderInput("years","Years:",
                  min=0, max = 50, value = 20, step = 1),
      radioButtons("facet", "Facet?:", choices = list("Yes" = TRUE, "No" = FALSE), selected = FALSE)
    ),
    mainPanel(
      tableOutput("values"),
      plotOutput("returns")
    )
  )
)

server <- function(input, output) {
  sliderValues <- reactive({
    valueswitch(input)
    data.frame(
      Name = c("Initial Amount", "Annual Contribution","Return Rate","Growth Rate","Years","facet?"),
      Value = as.character(c(input$initialamount,
                             input$annualcontribution,
                             input$returnrate,
                             input$growthrate,
                             input$years,
                             input$facet)),
      stringsAsFactors = FALSE)
  })
}
  
  shinyApp(ui, server)