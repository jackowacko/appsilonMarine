#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny shiny.semantic leaflet
#' @noRd
#' 
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
      semanticPage(
      grid(
        grid_template = get_grid() ,
        area_styles = list(box1 = "margin: 20px",box2 = "margin: 20px",box3 = "margin: 20px"
                           ,box4 = "margin: 20px",box5 = "margin: 20px",box6 = "margin: 20px"),
        box1 = h2(class = "ui header", icon("ship"), div(class = "content", textOutput("ship_name") )),
        box2 = div(class = "content" 
                        ,message_box(class = "info", header = "App Marine Example"
                                     ,  content = "For vessel selected show the longest distance sailed.")) ,
        box4 = mod_vessel_dropdown_ui("vessel_dropdown_ui_1"),
        box5 = h2(class = "ui header", icon("user"), div(class = "content", "Created by ",br(), a("Yackson Garcés", href = "https://www.linkedin.com/in/jacksongarces/"))),
        box6 = h2(class = "ui header", icon("arrows alternate horizontal"), div(class = "content", "Total meters sailed",  textOutput("total_dist"))),
        map =   leafletOutput("mymap", width = "100%", height = "100%")
      )
        
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'appsilonMarine'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

