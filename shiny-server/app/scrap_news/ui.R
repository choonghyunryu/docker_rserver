navbarPage(
  theme = shinythemes::shinytheme("cerulean"), 
  "네이버 뉴스 검색 애플리케이션",
  tabPanel(
    "뉴스 검색하기",
    sidebarLayout(
      sidebarPanel(
        textInput("client_id", 
                  label = h4("Client ID:"), 
                  value = client_id),
        textInput("client_secret", 
                  label = h4("Client Secret:"), 
                  value = client_secret),            
        textInput("keyword", 
                  label = h4("검색 키워드:"), 
                  value = ""),
        radioButtons("sort", label = h4("정렬 옵션:"),
                     choices = list("날짜순" = "date", "유사도순" = "sim"), 
                     selected = "date"),           
        sliderInput("max_record", label = h4("검색 건수:"), min = 0,
                    max = 500, value = 100, step = 100),
        actionButton("search_keyword", label = "뉴스 검색", 
                     icon = icon("newspaper"),
                     class = "btn-primary"),
        width = 3
      ),
      # Reactable에 검색 결과 리스트업
      mainPanel(
        reactableOutput("news_list"),
        width = 9
      )
    ),
    icon = icon("comments")
  ),
  
  tabPanel(
    "워드 클라우드",
    sidebarLayout(
      sidebarPanel(
        numericInput("remove_n", 
                     label = h4("상위 최대 돗수 제외 건:"), 
                     value = 5, min = 0
        ),
        numericInput("min_freq", 
                     label = h4("포함할 워드의 최소 돗수:"), 
                     value = 5, min = 1
        ),          
        colourInput("col_bg", 
                    label = h4("배경 색상:"), 
                    value = "white"),
        width = 3
      ),
      # 검색 결과 전체의 워드클라우드
      mainPanel(
        wordcloud2Output("cloud", height = "600px"),
        width = 9
      )
    ),
    icon = icon("chart-pie")
  )
)
