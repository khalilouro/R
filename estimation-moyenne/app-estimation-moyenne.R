library(shiny)

ui <- fluidPage(
  
  titlePanel("Estimation de la moyenne"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      numericInput("n", "Taille de l'échantillon :", value = 10, min = 2),
      
      textInput("data", "Entrer les valeurs séparées par des virgules :",
                "10,12,14,13,15,11,10,16,14,13"),
      
      actionButton("calc", "Calculer")
      
    ),
    
    mainPanel(
      
      h3("Résultats"),
      
      verbatimTextOutput("mean"),
      verbatimTextOutput("ic"),
      
      plotOutput("hist")
      
    )
  )
)

server <- function(input, output) {
  
  values <- eventReactive(input$calc, {
    
    x <- as.numeric(strsplit(input$data, ",")[[1]])
    x
    
  })
  
  output$mean <- renderText({
    
    x <- values()
    paste("Moyenne de l'échantillon :", mean(x))
    
  })
  
  output$ic <- renderText({
    
    x <- values()
    n <- length(x)
    m <- mean(x)
    s <- sd(x)
    
    erreur <- 1.96 * s / sqrt(n)
    
    bas <- m - erreur
    haut <- m + erreur
    
    paste("Intervalle de confiance (95%) :", round(bas,2), "-", round(haut,2))
    
  })
  
  output$hist <- renderPlot({
    
    hist(values(),
         main="Histogramme des données",
         col="lightblue",
         border="black")
    
  })
  
}

shinyApp(ui = ui, server = server)
