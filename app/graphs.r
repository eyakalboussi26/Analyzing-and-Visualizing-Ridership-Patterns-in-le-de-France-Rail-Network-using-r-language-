plot_time_series <- function(data, start_date, end_date) {
  data$JOUR <- as.Date(data$JOUR, format = "%m/%d/%Y")
  filtered_data <- data[data$JOUR >= as.Date(start_date) & data$JOUR <= as.Date(end_date), ]
  
  if (nrow(filtered_data) == 0) {
    stop("No data available for the specified date range.")
  }
  
  p <- ggplot(data, aes(x = JOUR, y = TOT_VAL)) +
    geom_line(color = "red") +
    scale_x_date(date_breaks = "1 day", date_labels = "%b %d")+
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1, size = 8)) +
    xlab("Date") +
    ylab("Total Value") +
    ggtitle("Smooth Line Plot")
  

  print(p)
}

