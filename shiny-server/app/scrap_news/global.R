# attach packages
library("shiny")
library("dplyr")
library("koscrap")
library("reactable")
library("htmltools")
library("tidytext")
library("wordcloud2")
library("colourpicker")

# Initialize global environments
write_api_key <- function(client_id = NULL, client_secret = NULL) {
  if (is.null(client_id)) {
    return()
  } else {
    client_info <- glue::glue("{client_id}:{client_secret}") %>%
      charToRaw() %>%
      base64enc::base64encode()

    write(client_info, file = ".api_key.info")
  }
}

get_api_key <- function(client_info) {
  client_info <- rawToChar(base64enc::base64decode(client_info)) %>%
    strsplit(":") %>%
    unlist()

  client_id <- client_info[1]
  client_secret <- client_info[2]

  list(client_id = client_id, client_secret = client_secret)
}

options(api.key.file = TRUE)

client_id <- ""
client_secret <- ""

if (getOption("api.key.file")) {
  if (grepl("scrap_news", getwd()) && file.exists(".api_key.info")) {
    client_info <- scan(file = ".api_key.info", what = "character")

    client_info <- get_api_key(client_info)
    
    client_id <- client_info$client_id
    client_secret <- client_info$client_secret    
  } else {
    options(api.key.file = FALSE)
  }
}

# create UDF
create_wordcloud <- function(data, remove_n = 5, min_freq = 5, background = "white") {
  data %>% 
    filter(nchar(description_text) > 0) %>%   
    unnest_tokens(noun, description_text, bitTA::morpho_mecab, type = "noun") %>% 
    group_by(noun) %>% 
    count() %>% 
    arrange(desc(n)) %>%     
    ungroup() %>%
    filter(n >= min_freq) %>% 
    filter(row_number() > remove_n) %>% 
    wordcloud2::wordcloud2(backgroundColor = background, 
                           fontFamily = "NamumSquare")
}
