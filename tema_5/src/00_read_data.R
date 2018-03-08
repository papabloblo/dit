library(readr)
library(rvest)
# read html ---------------------------------------------------------------

urls <- c("http://www.elmundo.es/espana/2018/03/06/5a9ec63e22601d66088b46b8.html",
          "https://politica.elpais.com/politica/2018/03/06/actualidad/1520331396_027110.html",
          "https://www.elconfidencial.com/espana/2018-03-06/huelga-feminista-8marzo-rajoy-rechaza-paro-japonesa_1531583/")


docs <- list()

for (i in seq_along(urls)){
  docs[[i]] <- read_html(urls[[i]]) %>% 
    html_nodes('p') %>% 
    html_text() %>% 
    paste(collapse = "")
}

docs <- unlist(docs)

write_rds(docs, "tema_5/data/documents_html.RDS")

  
  