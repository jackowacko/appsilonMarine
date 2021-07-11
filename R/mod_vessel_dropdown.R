#' vessel_dropdown cascade selector UI Function
#'
#' @description A shiny Module to do a dropdown filter over vessel.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList

mod_vessel_dropdown_ui <- function(id){
  ns <- NS(id)
  tagList(
    h3("Select vessel type"),
    dropdown_input(ns("shiptype"),  ship_type_choices , value = ship_type_choices[1], type = "selection fluid"),
    h3("Select vessel name") ,
     dropdown_input(ns("ship_name"),    ini_name_choices   , value =    ini_name_choices[1], type = "selection fluid")
  )
}
    
#' vessel_dropdown Server Functions
#'
#' @noRd 
mod_vessel_dropdown_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    new_shipnames_react <- reactive({
      ship_name_type %>% 
        dplyr::filter(ship_type == input$shiptype) %>% 
        dplyr::select(SHIPNAME) %>% 
        .[[1]]
      
      
    })    
    observeEvent(new_shipnames_react(), {
      
     
    
      update_dropdown_input(session, "ship_name", choices = new_shipnames_react(), value = new_shipnames_react()[1])
    })
    
    
  })
}
    
## To be copied in the UI
# mod_vessel_dropdown_ui("vessel_dropdown_ui_1")
    
## To be copied in the server
# mod_vessel_dropdown_server("vessel_dropdown_ui_1")
