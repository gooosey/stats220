scrape_search_results <- function(page_path) {
  # Read HTML
  html_doc <- read_html(page_path)
  
  # Extract the isolated search result nodes (the individual cards)
  nodes <- html_doc %>% html_elements(".search-result")
  
  # Map over each individual search result
  map_df(nodes, function(node) {
    # Title
    title_element <- node %>% html_element(".views-field-title a")
    title <- title_element %>% html_text2()
    
    # Date and time
    date_element <- node %>% html_element("time")
    datetime  <- date_element %>% html_attr("datetime")
    date_text <- date_element %>% html_text2()
    
    # Summary
    summary <- node %>% html_element(".views-field-search-api-excerpt") %>% html_text2()
    
    # Ministers
    minister <- node %>%
      html_elements(".views-field-field-ministers .minister__title, .views-field-field-ministers .is-archived") %>%
      html_text2() %>%
      str_trim() %>%
      paste(collapse = ";")
    
    # Portfolios
    portfolio <- node %>%
      html_elements(".views-field-field-portfolios a, .views-field-field-portfolios .is-archived") %>%
      html_text2() %>%
      str_trim() %>%
      paste(collapse = ";")
    
    # Combine individual results into a tidy tibble
    tibble(
      datetime   = datetime,
      date_text  = date_text,
      title      = title,
      ministers  = minister,
      portfolios = portfolio,
      summary    = summary
    )
  })
}
