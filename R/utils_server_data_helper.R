#' server_data_helper for extract data and do things
#'
#' @description A utils function helper for extract data and do things
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd
#' @import dplyr tidyverse sf

getDistSailed <- function(shipname_var){


  dist_calculated <- ship_data %>% 
    filter(SHIPNAME == ifelse(is.null(shipname_var) ,"KAROLI" , shipname_var )) %>% 
    arrange(date) %>% 
    sf::st_as_sf(coords = c("LON","LAT")) %>% 
    mutate(geometry_plain = sf::st_set_crs(geometry, 4326) %>% sf::st_transform( . , 27700) ) %>% 
    mutate(lagged_point = lag(geometry_plain)
           , lead_point = lead(geometry_plain)
           ,distance_prev = st_distance(geometry_plain, lagged_point,by_element = T)
           , distance_pos = st_distance(geometry_plain, lead_point ,by_element = T )
           ,sum_dist = distance_pos + distance_prev ) 
  
  
  points_1 <-  dist_calculated %>% 
    filter(sum_dist == max(sum_dist,na.rm = T)) %>% 
    mutate(lagged_point = lagged_point %>% sf::st_transform( . , 4326) 
           ,lead_point = lead_point %>% sf::st_transform( . , 4326) 
           , geometry_aux =  geometry_plain %>% sf::st_transform( . , 4326)  ) %>% 
    select(SHIPNAME, sum_dist , SPEED:HEADING, geometry_aux , lagged_point , lead_point ) %>% 
    tidyr::pivot_longer( cols = geometry_aux:lead_point) %>% 
    select(-geometry) 
  
  total_sailed <- dist_calculated %>% 
    summarise(total_sailed = sum(sum_dist, na.rm=T)) %>% 
    as_tibble() %>% 
    select(-geometry) 
  
  points_1 <- bind_cols( points_1,do.call(rbind, st_geometry(points_1$value)) %>% 
                           as_tibble() %>% setNames(c("lon","lat")))[c(2,3),]
  
  output <- list(points = points_1, total_sailed = total_sailed)
  
  return(output) 
  
}