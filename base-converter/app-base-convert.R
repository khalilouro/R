# ================================
# Fonctions de décodage / encodage
# ================================

DecodeDigits <- function(word, alphabet = c(0:9, LETTERS)) {
  digits <- unlist(strsplit(toupper(word), NULL))
  return(match(digits, alphabet) - 1)
}

# Décode un nombre écrit dans une base entre 2 et 36
DecodeNumber <- function(word, base) {
  
  digits <- DecodeDigits(word)
  
  i <- 1
  while(i <= length(digits)) {
    if(digits[i] >= base) {
      return(NA)
    }
    i <- i + 1
  }
  
  n <- 0
  i <- 1
  
  while(i <= length(digits)) {
    n <- n * base + digits[i]
    i <- i + 1
  }
  
  return(n)
}

# Encode un nombre dans une base entre 2 et 36
EncodeNumber <- function(n, base) {
  
  alphabet <- c(0:9, LETTERS)
  
  if(n == 0) {
    return("0")
  }
  
  digits <- c()
  
  while(n > 0) {
    r <- n %% base
    digits <- c(alphabet[r + 1], digits)
    n <- n %/% base
  }
  
  return(paste(digits, collapse = ""))
}

# Encode un nombre en système Bibi-binaire
EncodeBibi <- function(n) {
  
  bin <- EncodeNumber(n, 2)
  
  dico <- c(
    "00" = "HO",
    "01" = "HA",
    "10" = "HI",
    "11" = "HU"
  )
  
  if(nchar(bin) %% 2 == 1) {
    bin <- paste("0", bin, sep = "")
  }
  
  res <- ""
  i <- 1
  
  while(i <= nchar(bin)) {
    pair <- substr(bin, i, i + 1)
    res <- paste(res, dico[pair])
    i <- i + 2
  }
  
  return(res)
}


# ================================
# Application Shiny
# ================================

library(shiny)

server <- function(input, output) {
  
  CheckBase <- function(base) base >= 2 && base <= 36
  
  fromBase <- reactive({
    validate(
      need(!is.na(input$fromBase), "Base d'origine manquante"),
      need(CheckBase(input$fromBase), "Base d'origine doit être entre 2 et 36.")
    )
    input$fromBase
  })
  
  number <- reactive({
    
    number <- trimws(input$number)
    
    validate(
      need(nchar(number) > 0, "Pas de nombre en entrée."),
      need(!grepl("[^a-zA-Z0-9]", number), "Format de nombre incorrect")
    )
    
    number <- DecodeNumber(number, fromBase())
    
    validate(
      need(!is.na(number), "Chiffres invalides dans le nombre.")
    )
    
    number
  })
  
  ConvertNumber <- function(n, base) {
    
    validate(
      need(!is.na(base), "Base de destination manquante")
    )
    
    if(CheckBase(base)) {
      return(EncodeNumber(n, base))
    } else {
      return(EncodeBibi(n))
    }
  }
  
  output$toBase1 <- renderText({
    ConvertNumber(number(), input$toBase1)
  })
  
  output$toBase2 <- renderText({
    ConvertNumber(number(), input$toBase2)
  })
  
  output$toBase3 <- renderText({
    ConvertNumber(number(), input$toBase3)
  })
}


# ================================
# Interface graphique
# ================================

ui <- fluidPage(
  
  titlePanel("Convertisseur à Bibi"),
  
  sidebarLayout(
    
    sidebarPanel(
      textInput("number", "Nombre", "26"),
      numericInput("fromBase", "Depuis la base:", "10")
    ),
    
    mainPanel(
      
      column(
        4,
        numericInput("toBase1", "Vers la base:", "10"),
        verbatimTextOutput("toBase1")
      ),
      
      column(
        4,
        numericInput("toBase2", "Vers la base:", "2"),
        verbatimTextOutput("toBase2")
      ),
      
      column(
        4,
        numericInput("toBase3", "Vers la base:", "16"),
        verbatimTextOutput("toBase3")
      )
      
    )
  )
)

# ================================
# Lancement de l'application
# ================================

shinyApp(ui = ui, server = server)
