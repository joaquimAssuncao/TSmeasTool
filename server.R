#################### TS analysis tools- shinny server ##########################
# 2015 by Joaquim Assuncao (www.joaquim.pro.br)
# jassuncao@outlook.com
#####################################################

library(shiny)
source("tools.r")

shinyServer(function(input, output) {
     output$contents <- renderTable({
          inFile <- input$file1
          
          if (is.null(inFile))
               return(NULL)
          
          usr_data <<- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                                quote=input$quote)
          
          #Na to 0
          if (input$naTo==TRUE){
               usr_data[is.na(usr_data)] <<- 0
          }
          #Na as previous
          if (input$naAsPrev==TRUE){    
               usr_data <<- na.lomf(usr_data)
               
          }
          
          #Normalize
          if (input$norm==TRUE){
               for (c in 1:ncol(usr_data)){
                    if (is.numeric(usr_data[,c])){
                         for (l in 1:nrow(usr_data)){
                              #used to avoid NAs
                              if (!is.na(usr_data[l,c])){
                                   usr_data[l,c] <<- usr_data[l,c]/max(usr_data[!is.na(usr_data[,c]),c])  
                              }   
                         }  
                    }
               }
          }
          
          usr_data
     })
     
     
     
     generateDTW <- eventReactive(input$generateDTWanalisys, {
          selCols  <- as.numeric(strsplit(input$selCols, ",")[[1]]) 
          maxLines <- as.numeric(input$maxLines)
          DTWgetalignment(usr_data[,selCols],maxLines)
          DTWplot()
          
     })
     
     
     output$downloadData <- downloadHandler(
          filename = function() { 
               paste("usr_data", '.csv', sep='') 
          },
          content = function(file) {
               write.csv(usr_data, file)
          }
     )
     
     output$DTW <- renderPlot({
          generateDTW()
          
          output$measurements <- renderText({
               distanceMeasurements()
          })
          output$mean <- renderText({
               getSummary()   
          })
          output$min <- renderText({
               pasteMin()
          })
          output$max <- renderText({
               pasteMax()
          })
          output$trend <- renderPlot({
               generateTrendTSa()
          })
          output$trend <- renderPlot({
               generateTrendTSb()
          })
          
          
     })
     
    

     
})
