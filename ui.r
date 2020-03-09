library(shiny)
library(shinydashboard)
library(shinythemes)
shinyUI(dashboardPage(skin="yellow",
  
  dashboardHeader(title = "Loan Prediction", titleWidth = 350),
  
  dashboardSidebar(
    h3("Inputs:"),
    selectInput("Married", label = h3("Marriage status"), 
                choices = list("Yes"=1,"No"=2),
                selected = 1),
    #helpText(" '1' represents applicant Married and '2' represents its not"),
    selectInput("Education", label = h3("Education status"), 
                choices = list("Educated"=1,"Not Educated"=2),
                selected = 1),
    numericInput("LoanAmount", label = h3("Loan Amount"), 50, min = 1, max = 70000),
    numericInput("Credit_History", label = h3("Credit History"), 0, min = 0, max = 1),
    submitButton('Submit'),
    width = 350
  ),
  dashboardBody(
      
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    h2('Prediction Results'),
    #h4('Entered Values:'),
    #verbatimTextOutput("Married",placeholder = TRUE),
    #verbatimTextOutput("Education"),
    #verbatimTextOutput("LoanAmount"),
    #verbatimTextOutput("Credit_History"),
    h4('Prediction probability for loan approval:'),
    fluidRow(
      valueBoxOutput("prediction")
    ),
    #verbatimTextOutput("Pred"),
    fluidRow(
      box(title = "Pie Chart", status = "primary", solidHeader = TRUE,
          collapsible = TRUE,
          plotOutput("plot1", height = 250))
    )
    
  ) 
  
  
))
