
# Vocabulario -------------------------------------------------------------
vocabulario <- unique(rasgos_tfidf$word_stem)

write_lines(paste(vocabulario, 
                  collapse = " "),
            "tema_5/data/vocabulario.txt")

# Representaciones --------------------------------------------------------


repres_vocab <- data_frame(vocabulario = vocabulario)

for (i in unique(rasgos_tfidf$id)){
  res <- rasgos_tfidf %>% 
    filter(id == i) %>% 
    select(word_stem) %>% 
    mutate(peso = 1L) %>% 
    distinct() %>% 
    right_join(repres_vocab, by = c("word_stem" = "vocabulario")) %>% 
    mutate(peso = ifelse(is.na(peso), 0L, peso))
  
  write_lines(paste(res$peso, 
                    collapse = " "),
              paste0("tema_5/data/representacion_", i, ".txt"))
}



# Fichero invertido -------------------------------------------------------


doc_id <- sort(unique(rasgos_tfidf$id))

a <- data_frame(doc = rep(doc_id, length(vocabulario)),
           term = rep(vocabulario, each = length(doc_id)))

b <- rasgos_tfidf %>% 
  select(id, word_stem, tf) %>% 
  right_join(a, by = c("word_stem" = "term", "id" = "doc")) %>% 
    mutate(tf = ifelse(is.na(tf), 0L, tf),
           doc = paste0("doc", id, ":", tf )) 

x <- c()  
for (v in vocabulario){
  x <- c(x,
         paste(v, "<-", paste(filter(b, word_stem == v)$doc, collapse = " ")))
}

write_lines(x,
            "tema_5/data/fichero_invertido_tf.txt")


b <- rasgos_tfidf %>% 
  select(id, word_stem, tf_idf) %>% 
  right_join(a, by = c("word_stem" = "term", "id" = "doc")) %>% 
  mutate(tf_idf = ifelse(is.na(tf_idf), 0L, tf_idf),
         doc = paste0("doc", id, ":", tf_idf)) 

x <- c()  
for (v in vocabulario){
  x <- c(x,
         paste(v, "<-", paste(filter(b, word_stem == v)$doc, collapse = " ")))
}

write_lines(x,
            "tema_5/data/fichero_invertido_tfidf.txt")
