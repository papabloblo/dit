library(readr)
library(rvest)
# read html ---------------------------------------------------------------

urls <- c("https://www.elconfidencial.com/espana/2018-03-08/masivo-en-colegios-residual-en-hospitales-mas-de-cinco-millones-paran-por-la-huelga_1532619/",
          "https://politica.elpais.com/politica/2018/03/08/actualidad/1520489139_477620.html",
          "http://www.elmundo.es/espana/2018/03/08/5aa14585268e3e154f8b45c2.html",
          "http://www.abc.es/sociedad/abci-huelga-feminista-8-marzo-201803080818_directo.html",
          "https://www.larazon.es/sociedad/siga-minuto-a-minuto-toda-la-informacion-sobre-el-dia-de-la-mujer-y-la-huelga-del-8-m-BK17843354",
          "https://www.larazon.es/sociedad/el-8-de-marzo-una-reivindicacion-y-muchos-manifiestos-BN17831303",
          "http://www.publico.es/sociedad/sindicatos-calculan-5-3-millones-trabajadores-secundan-paros-horas.html")


docs <- list()

for (i in seq_along(urls)){
  docs[[i]] <- read_html(urls[[i]]) %>% 
    html_nodes('p') %>% 
    html_text() %>% 
    paste(collapse = "")
}

docs <- unlist(docs)

write_rds(docs, "tema_5/data/documents_html.RDS")

  
  