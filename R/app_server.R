#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny leaflet dplyr tidyverse sf htmltools
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  
  # call Modules
  mod_vessel_dropdown_server("vessel_dropdown_ui_1")
  
  output$mymap <- renderLeaflet({
   
    data_points <- getDistSailed(ship_name_reac())$points
    
    leaflet( ) %>% 
      addTiles(group = "OSM") %>% 
      addMarkers( data= data_points
                  , icon = makeIcon(iconUrl = "www/ship_icon.png")
                  , label = ~ as.character(paste(sep= "\n" 
                                               , paste0("Max distance sail " , round(sum_dist,0) ," meters")
                                               , SHIPNAME)
                  )
                  )
  })
  
   ship_name_reac <- reactive({
     input$`vessel_dropdown_ui_1-ship_name` })
  
  
  observeEvent( ship_name_reac(),{ 
    
    data_points <- getDistSailed(ship_name_reac())$points
    
    leafletProxy("mymap", session ) %>%
      clearMarkers() %>% 
      addTiles(group = "OSM") %>% 
      addMarkers( data= data_points 
                  , icon = makeIcon(iconUrl = "www/ship_icon.png")
                  , label = ~ as.character(paste(sep= "\n" 
                                               , paste0("Max distance sailed " , round(sum_dist,0) ," meters")
                                               , SHIPNAME)
                  ))
    
  })
  
  output$ship_name <- renderText({
  
    input$`vessel_dropdown_ui_1-ship_name`  
    
  })
  
  output$total_dist <- renderText({
    
    getDistSailed(ship_name_reac())$total_sailed %>% unlist()
    
  })
  
  }


