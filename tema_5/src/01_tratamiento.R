library(tidyverse)
library(tidytext)
library(tm)



text_df <- data_frame(id = 1:length(docs),
                      text = docs)


# Tokenization ------------------------------------------------------------

rasgos <- text_df %>% 
  unnest_tokens(word, text)



# Drop stop words ---------------------------------------------------------

rasgos <- rasgos %>% 
  filter(!word %in% stopwords("es"))


# Stemming ----------------------------------------------------------------

rasgos <- rasgos %>% 
  mutate(word_stem = stemDocument(word,
                                  language = "spanish")
         )



# Funciones de pesado -----------------------------------------------------

rasgos_tf <- rasgos %>% 
  group_by(id, word_stem) %>% 
  summarise(tf = n()) %>% 
  ungroup() %>% 
  arrange(desc(tf))

rasgos_idf <- rasgos %>% 
  select(id, word_stem) %>% 
  mutate(tot_doc = n_distinct(id)) %>% 
  distinct() %>% 
  group_by(word_stem) %>% 
  mutate(idf = log(tot_doc/n()))

rasgos_tfidf <- rasgos_tf %>% 
  left_join(rasgos_idf) %>% 
  mutate(tf_idf = tf*idf)



