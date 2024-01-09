
library(dplyr)

read_data <- function(path){
  data = read.csv(path)
  data = data %>% filter(NB_VALD != "Moins de 5")
  data$JOUR <- as.Date(data$JOUR, format = "%m/%d/%Y")
  return(data )
}

daily_validation <- function(data){
  result = data %>% group_by(JOUR) %>% mutate(TOT_VAL = cumsum(NB_VALD))%>% summarise(TOT_VAL = max(TOT_VAL))
  return(result)
}

daily_arret <- function(data){
result =  data %>%
  group_by(JOUR, LIBELLE_ARRET) %>%
  summarise(TOT_VAL = sum(as.numeric(NB_VALD))) %>%
  group_by(JOUR) %>%
  slice(which.max(TOT_VAL))
  
}

most_used_arret <- function(data){
  data = daily_arret(data)
  most_used <- data %>%
    group_by(LIBELLE_ARRET) %>%
    summarise(total_value = sum(TOT_VAL)) %>%
    arrange(desc(total_value)) %>%
    slice(1)
  return(most_used)
  
}

