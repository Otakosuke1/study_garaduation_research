ui <- grid_page(
  layout = c(
    "up             sele          ",
    "card_for_plot2 card_for_plot2"
  ),
  row_sizes = c(
    "1fr",
    "3fr"
  ),
  col_sizes = c(
    "1fr",
    "1fr"
  ),
  gap_size = "1rem",
  
  grid_card(
    area = "up",
    card_header("upload"),
    card_body(
      div(
        style = "width: 100%,",
        fluidPage(
          sidebarLayout(
            sidebarPanel(# アップロードボタン
              fileInput("file1", "ファイルを選択してください",
                        accept = c("text/csv","text/comma-separated-values,text/plain",".csv")
              ),
              width = 20
            ),
            mainPanel(tableOutput("contents"),width = 20)
          )
        )
      )
    )
  ),
  grid_card(
    area = "sele",
    card_header("select research"),
    card_body(
      selectInput(
        inputId = "data",
        label = NULL,
        choices = list("example" = "example", "others" = "others")
      ),
      actionButton(inputId = "start", label = "start")
    )
  ),
  
  grid_card(
    area = "card_for_plot2",
    full_screen = TRUE,
    card_header("Matching　plot"),
    card_body(
      selectInput(
        inputId = "plottype",
        label = "Which plot",
        choices = list(
          "emg heatmap" = "filt_heat",
          "psd heatmap" = "psd_heat",
          "coherence heatmap" = "coh_heat",
          "synergy" = "syns"
        )
      ),
      
      grid_container(
        layout = c(
          "area0 area1"
        ),
        row_sizes = c(
          "1fr"
        ),
        col_sizes = c(
          "1fr",
          "1fr"
        ),
        gap_size = "10px",
        grid_card(
          area = "area0",
          card_header("young"),
          card_body(plotOutput(outputId = "plot_y"))
        ),
        grid_card(
          area = "area1",
          card_header("elderly"),
          card_body(plotOutput(outputId = "plot_e"))
        )
      )
    )
  )
)