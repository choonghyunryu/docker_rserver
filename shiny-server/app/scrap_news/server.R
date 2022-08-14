function(input, output, session) {
    newsList <- reactiveValues(
      list = data.frame(
        title = character(0),
        description = character(0),
        publish_date = character(0),
        link = character(0),
        stringsAsFactors = FALSE
      ) %>% 
        reactable(
          defaultColDef = colDef(
            align = "left"
          ),
          columns = list(
            title = colDef(
              name = "타이틀",
              width = 250,
            ),
            description = colDef(name = "뉴스내용 요약"),
            publish_date = colDef(
              name = "뉴스 계시시간",
              width = 150,
            ),
            link = colDef(
              name = "뉴스 링크",
              width = 250,
              html = TRUE,
              cell = function(url) {
                htmltools::tags$a(href = as.character(url), target = "_blank", as.character(url))
              }
            )    
          ),
          showPageSizeOptions = TRUE,
          pageSizeOptions = c(5, 10, 15), 
          defaultPageSize = 5,
          bordered = TRUE,
          highlight = TRUE
        )    
    )
    
    output$news_list <- renderReactable({
      newsList$list <-scraped_news() %>%
        mutate(title = title_text) %>%
        mutate(description = description_text) %>%
        mutate(publish_date = stringr::str_remove_all(publish_date,
                                                      "[[:alpha:]]")) %>%
        select(title, description, publish_date, link) %>% 
        reactable(
          defaultColDef = colDef(
            align = "left"
          ),
          columns = list(
            title = colDef(
              name = "타이틀",
              width = 250,
            ),
            description = colDef(name = "뉴스내용 요약"),
            publish_date = colDef(
              name = "뉴스 계시시간",
              width = 150,
            ),
            link = colDef(
              name = "뉴스 링크",
              width = 250,
              html = TRUE,
              cell = function(url) {
                htmltools::tags$a(href = as.character(url), target = "_blank", as.character(url))
              }
            )    
          ),
          showPageSizeOptions = TRUE,
          pageSizeOptions = c(5, 10, 15), 
          defaultPageSize = 5,
          bordered = TRUE,
          highlight = TRUE
        )
    })
    
    scraped_news <- eventReactive(input$search_keyword, {
      # 3개의 텍스트는 반드시 입력해야 함
      req(input$keyword)
      req(input$client_id)
      req(input$client_secret)
      
      write_api_key(input$client_id, input$client_secret)
      
      koscrap::search_naver(
        query = input$keyword,
        sort  = input$sort,
        chunk = min(input$max_record, 100),
        max_record = input$max_record,
        do_done = TRUE,
        client_id = input$client_id,
        client_secret = input$client_secret)
      })
  
  output$cloud <- renderWordcloud2({
    data <- scraped_news()
    
    create_wordcloud(
      data,
      remove_n = input$remove_n,
      min_freq = input$min_freq,
      background = input$col_bg
    )
  })
}
