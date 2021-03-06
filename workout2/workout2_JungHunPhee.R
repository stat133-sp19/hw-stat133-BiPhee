library(shiny)
library(ggplot2)
  ui <- shinyUI(fluidPage(
    titlePanel("The App"),
    fluidRow(
      sidebarPanel(
        column(4,sliderInput(inputId = "ia", "Initial Amount:", min = 0, max = 100000, value = 1000, step = 500),
               sliderInput(inputId = "a", "Annual Contribution:", min=0, max = 50000, value = 2000, step = 500)),
        column(4,
               sliderInput(inputId = "r", "Return Rat:", min=0, max=0.20, value=0.05, step=0.001),
               sliderInput(inputId = "g", "Growth Rate:", min=0, max = 0.2, value = 0.02, step = 0.001)),
        column(4,sliderInput(inputId = "y","Years:", min=0, max = 50, value = 20, step = 1),
               selectInput(inputId = "f","Facet?",choices = c("Yes" = "TRUE","No" = "FALSE"), selected = FALSE))
      )
    ),
    mainPanel(
      h3("Timelines"),
      plotOutput("timelines"),
      h3("Balance"),
      tableOutput("balance")
    )
  )
)

server <- shinyServer(function(input, output) {
  future_value<-function(amount, rate, years){
    fv<-amount*(1+rate)^(years)
    return(fv)
  }
  annuity<-function(contrib, rate, years){
    balance<-contrib*(((1+rate)^(years)-1)/rate)
    return(balance)
  }
  growing_annuity<-function(contrib,rate,growth,years){
    balance<-contrib*((((1+rate)^(years))-(1+growth)^(years))/(rate-growth))
    return(balance)
  }
  
  nofacet <- function(ia, a, r,g,y){
    year <- c(0:y)
    no_contrib<-c()
    growing_contrib<-c()
    fixed_contrib<-c()
    for(i in year){
      no_contrib[i+1]<-future_value(amount = ia, rate = r, years = i)
      fixed_contrib[i+1]<-annuity(contrib = a, rate = r, years =i) + no_contrib[i+1]
      growing_contrib[i+1]<-growing_annuity(contrib = a, rate = r, growth = g, years = i) + no_contrib[i+1]
    }
    modality<-data.frame(year, no_contrib, fixed_contrib, growing_contrib)
    meltmodality<-reshape2::melt(modality,id.var='year')
    plot<-ggplot(data = meltmodality, aes(x=year, y = value, col = variable))+
      geom_line()+
      labs(x="Year", y = "Balance")+
      theme(legend.position = 'right')
    return(plot)
  }
  
  yesfacet<-function(ia,a,r,g,y){
    balance<-c()
    for (i in 0:y){
      balance[i+1]<-future_value(ia,r,years = i)
      balance[i + y + 2] <-future_value(ia,r,i) +annuity(a,r,i)
      balance[i+2*y+3] <- future_value(ia,r,i)+growing_annuity(contrib = a,rate = r, growth = g, years = i)
    }
    year <- c(0:y, 0:y, 0:y)
    type <- c()
    for (i in 0:y){
      type[i+1]<- "no_contrib"
      type[i+y+2]<-"fixed contrib"
      type[i+2*y+3]<-"growing contrib"
    }
    modality_facet<-data.frame(year, balance, type)
    modality_facet_melted <- reshape2::melt(modality_facet, id.var = c('year','type'))
    plot <- ggplot(data=modality_facet_melted, aes(x=year,y=balance,col=type))+
      geom_line()+
      facet_wrap(~type)+
      labs(x="Year", y="Balance", title ="Three models of investing")+
      theme(legend.position='right')
    return(plot)
  }
  
  facetornot<- reactive({
    dist<-switch(input$f,
                 "TRUE" = yesfacet,
                 "FALSE" = nofacet)
    dist(input$ia, input$a, input$r, input$g, input$y)
  })
  
  table_maker <- function(ia,a,r,g,y){
    no_contrib<-c()
    fixed_contrib<-c()
    growing_contrib<-c()
    year<-c(0:y)
    for(i in year){
      no_contrib[i+1]<-future_value(amount = ia, rate = r, years = i)
      fixed_contrib[i+1]<-annuity(contrib = a, rate = r, years =i) + no_contrib[i+1]
      growing_contrib[i+1]<-growing_annuity(contrib = a, rate = r, growth = g, years = i) + no_contrib[i+1]
    }
    modalities<-data.frame(year, no_contrib, fixed_contrib, growing_contrib)
    return(modalities)
  }
  
  output$balance <- renderTable({table_maker(input$ia, input$a, input$r, input$g, input$y)})
  output$timelines <-renderPlot({facetornot()})
}
)

shinyApp(ui = ui, server = server)