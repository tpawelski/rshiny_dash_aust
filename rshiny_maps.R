install.packages("ASGS.foyer")
ASGS.foyer::install_ASGS()
library(ASGS)

#plot(SA1_2011_simple)

library(rmapshaper)
library(leaflet)
library(shiny)

sa1 <- ms_simplify(SA1_2016)

sa1<- readRDS("sa1.RDS")
# Create main map
primary_map <- leaflet() %>% 
  addProviderTiles(
    providers$OpenStreetMap,
    options = providerTileOptions(opacity = 0.60)
  ) %>% 
  # Layer 0 (blank)
  addPolygons(
    data = sa1,
    color = "#444444", weight = 1, smoothFactor = 0.5,
    opacity = 1.0, fillOpacity = 0.2
  ) 

primary_map


library(shinydashboard)

#ui <- fluidPage(
  #leafletOutput("mymap")
#)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
    leafletOutput("mymap")
  )
)

server <- function(input, output) {
  output$mymap <- renderLeaflet({
    leaflet(sa1) %>% 
      addProviderTiles(
        providers$OpenStreetMap,
        options = providerTileOptions(opacity = 0.60)
      ) %>% 
      # Layer 0 (blank)
      addPolygons(
        data = sa1,
        color = "#444444", weight = 1, smoothFactor = 0.5,
        opacity = 1.0, fillOpacity = 0.2
      ) 
    
  })
}

runApp(shinyApp(ui, server), launch.browser=TRUE)

