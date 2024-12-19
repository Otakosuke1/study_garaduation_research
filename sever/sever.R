# serverの内容を定義
server <- function(input, output, session) {
  observeEvent(input$start, {
    if (input$data == "example") {
      source('/home/ohta/Atlas/study_graduation_research/sever/sever_example.R', local = TRUE)
    }
    
    else {
      print("No data")
    }
  })
}

