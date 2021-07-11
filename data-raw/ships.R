## code to prepare `ships` dataset goes here
#
ship_data <- data.table::fread("/home/jackson/Descargas/ships_04112020/ships.csv") %>% 
  as_tibble()

 ship_name_type <-  ship_data %>% 
   select(SHIPNAME, ship_type) %>% 
   distinct()

 ship_type_choices <-   ship_name_type %>% 
   select(ship_type) %>% 
   distinct() %>% 
   .[[1]]
 
 ini_name_choices <-  ship_name_type %>% 
   filter(ship_type == ship_type_choices[3]) %>% 
   select(SHIPNAME) %>% 
   .[[1]]
# ship_name_type %>% 
#   filter(ship_type == "Cargo")

 
   
 
usethis::use_data(ship_data, overwrite = F)
usethis::use_data(ship_name_type, overwrite = TRUE)
usethis::use_data( ship_type_choices, overwrite = TRUE)
usethis::use_data(  ini_name_choices , overwrite = TRUE)
