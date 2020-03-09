library(faraway)
library(shiny)
library(caret)
library(rsconnect)
#data("teengamb")
MyGLmodel_New <- load("GLModel_v1.rda")    # Load saved model
setwd("C:/Users/vishaln/Desktop/ShinyDemo/LoadPrediction/Test Run")

# Conditional icon for widget.
# Returns arrow-up icon on true (if true_direction is 'up'), e.g. load time % change > 0
cond_icon <- function(condition, true_direction = "up") {
  
  if (true_direction == "up") {
    return(icon(ifelse(condition, "arrow-up", "arrow-down")))
  }
  
  return(icon(ifelse(condition, "arrow-down", "arrow-up")))
}

# Conditional color for widget
# Returns 'green' on true, 'red' on false, e.g. api usage % change > 0
#                                               load time % change < 0
cond_color <- function(condition, true_color = "green") {
  if(is.na(condition)){
    return("black")
  }
  
  colours <- c("green","red")
  return(ifelse(condition, true_color, colours[!colours == true_color]))
}

cond_title <- function(condition, true_title = "Decline Loan Application") {
  if(is.na(condition)){
    return("Reject")
  }
  
  titlee <- c("Decline Loan Application","Approve Loan Application")
  return(ifelse(condition, true_title, titlee[!titlee == true_title]))
}

shinyServer(
  function(input, output){
    #output$Married <- renderPrint({input$Married})
    #output$Education <- renderPrint({input$Education})
    #output$LoanAmount <- renderPrint({input$LoanAmount})
    #output$Credit_History <- renderPrint({input$Credit_History})
    #output$prediction <- renderPrint({Predictinput(as.numeric(input$Married), as.numeric(input$Education), input$LoanAmount, input$Credit_History)})
    data <- reactive({data.frame(
      Married = as.numeric(input$Married), 
      Education = as.numeric(input$Education), 
      LoanAmount = input$LoanAmount, 
      Credit_History = input$Credit_History
    )})
    #Prediction using GLM model:
    pred <- reactive({
      predict(get(MyGLmodel_New),data(), type="response")
    })
    
    #creating the valueBoxOutput content
    #output$value1 <- renderValueBox({valueBox(round(pred()*100,2), "Prediction %", icon = icon("stats",lib='glyphicon') ,color = "purple", width = 1)})
    output$prediction <- renderValueBox({
    valueBox(
      #subtitle = sprintf("Loan Approval Prediction (%.1f%%)"),
      subtitle = cond_title(pred() < 0.5),                   
      value = round(pred()*100,2),
      color = cond_color(pred() > 0.5),
      icon = cond_icon(pred() > 0.5)
    )
    })
    }
)
