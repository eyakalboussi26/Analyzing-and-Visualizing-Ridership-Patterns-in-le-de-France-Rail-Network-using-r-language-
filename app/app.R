

# Load libraries
library(shiny)
library(ggplot2)
library(dplyr)

source("app/data_proc.r")
source("app/graphs.r")

s1_2017 = read_data("app/data/Data2017/NbValidS1_cleaned")
s2_2017 = read_data("app/data/Data2017/NbValidS2_cleaned")
s1_2018 = read_data("app/data/Data2017/NbValidS1_cleaned")
s2_2018 = read_data("app/data/Data2017/NbValidS2_cleaned")
s1_2019 = read_data("app/data/Data2017/NbValidS1_cleaned")
s2_2019 = read_data("app/data/Data2017/NbValidS2_cleaned")



# Load the list of stations from a CSV file
station_list <- read.csv("stations.csv")

# Define the UI
ui <- fluidPage(
  titlePanel("Ridership Summary"),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("date_range", "Select Date Range", start = "2017-01-01", end = "2017-03-01"),
      selectInput("selected_year", "Select Year", choices = c("2017", "2018", "2019")),
      selectInput("selected_station", "Select Station", choices = unique(station_list$LIBELLE_ARRET)),
      actionButton("update", "Update Graph")
    ),
    mainPanel(
      plotOutput("date_plot"),
      plotOutput("ticket_category_dist_plot"),
      wellPanel(
        textOutput("most_used_station_text"),
        textOutput("selected_station_text")
      )
    )
  )
)

# Define the server logic
server <- function(input, output) {
  # Reactive function to generate the plot based on input parameters
  reactive_data <- reactive({
    # Get the selected year
    selected_year <- input$selected_year
    
    # Dynamically select the appropriate data frame based on the selected year
    data <- switch(selected_year,
                   "2017" = s1_2017,
                   "2018" = s1_2018,
                   "2019" = s1_2019,
                   s1_2017)  # Default to s1_2017 if the selected year is not recognized
    
    # Filter data based on selected date range
    start_date <- as.Date(input$date_range[1], format = "%Y-%m-%d")
    end_date <- as.Date(input$date_range[2], format = "%Y-%m-%d")
    filtered_data <- data[data$JOUR >= start_date & data$JOUR <= end_date, ]
    
    return(filtered_data)
  })
  
  daily_valid <- reactive({
    filtered_data <- reactive_data()
    daily <- daily_validation(filtered_data) 
    return(daily)
  })
  
  most_used_station <- reactive({
    filtered_data <- reactive_data()
    most_used <- most_used_arret(filtered_data) 
    return(most_used)
  })
  
  categ <- reactive({
    filtered_data <- reactive_data()
    filtered_data <- filtered_data %>% group_by(CATEGORIE_TITRE) %>% summarize(NB_VALD = sum(as.numeric(NB_VALD), na.rm = TRUE))
    return(filtered_data)
  })
  
  # Reactive function to filter data for the selected station
  reactive_selected_station_data <- reactive({
    selected_station <- input$selected_station
    filtered_data <- reactive_data()
    filtered_data <-filtered_data%>%group_by(LIBELLE_ARRET) %>%summarise(NB_VALD = sum(as.numeric(NB_VALD)))
    selected_station_data <- filtered_data[filtered_data$LIBELLE_ARRET == selected_station, ]
    
    return(na.omit(selected_station_data))
  })
  
  # Render the plot for the most used station
  output$date_plot <- renderPlot({
    ggplot(daily_valid(), aes(x = JOUR, y = TOT_VAL)) +
      geom_line() +
      labs(title = "Daily Evolution of ticket validations", x = "Date", y = "Value") + theme_minimal()
  })
  
  # Render the plot for the distribution of ticket categories for S2 line
  output$ticket_category_dist_plot <- renderPlot({
    ggplot(categ(), aes(x = CATEGORIE_TITRE, y = NB_VALD, fill = CATEGORIE_TITRE)) +
      geom_bar(stat = "identity") +
      labs(x = "Category of Ticket", y = "Number of Validations", title = "Distribution of validations for Ticket Transport category") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # Display the most used station
  output$most_used_station_text <- renderText({
    paste("The most used station is:", most_used_station()$LIBELLE_ARRET)
  })
  
  # Display the number of validations for the selected station
  output$selected_station_text <- renderText({
    output$selected_station_text <- renderText({
      selected_station_data <- reactive_selected_station_data()
      paste("Number of validations for", input$selected_station, "is:", selected_station_data$NB_VALD)
    })
  })
  
  # Update the date range input on button click
  observeEvent(input$update, {
    # No need to update the date range input here
  })
}

# Run the application
shinyApp(ui, server)
