#' ui_helpers 
#'
#' @description A utils function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd
#' 
#' 

get_grid <- function(){
  
  mygrid <- shiny.semantic::grid_template(
    default = list(
      areas = rbind(
        c("box1", "box2", "box2")
        ,c("map","map", "map")
        ,c("box4","box5","box6")
      ),
      cols_width = c("auto", "auto", "auto"),
      rows_height = c("auto", "600px", "auto")
    )
  )
  
  mygrid
  
}
