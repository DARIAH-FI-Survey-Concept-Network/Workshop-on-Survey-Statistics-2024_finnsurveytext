#### köyhyys, nälänhätä, sota, ilmastonmuutos

##############################
## Install and Load Package ##
##############################

install.packages("finnsurveytext")
## Backup option
# remotes::install_github("DARIAH-FI-Survey-Concept-Network/finnsurveytext")

library(finnsurveytext)
install.packages("survey")
library(survey)

View(dev_coop)
svy <- survey::svydesign(id = ~1, weights = ~paino, data = dev_coop)

##############################
#### Demo part 1: Prepare ####
##############################

df <- fst_prepare(data = dev_coop,
                  question = 'q11_3',
                  id = 'fsd_id',
                  model = 'ftb',
                  stopword_list = 'nltk', # DEFAULT VALUE, can also provide your own list or chose another swords list
                  language = 'fi', # DEFAULT VALUE
                  weights = 'paino',
                  add_cols = 'gender, region'
                  )
# udpipe::udpipe_download_model(language = 'finnish-ftb')
View(df)

# prepare with svydesign object
df2 <- fst_prepare_svydesign(svydesign = svy,
                             question = 'q11_3',
                             id = 'fsd_id',
                             model = 'ftb',
                             use_weights = TRUE,
                             add_cols = 'gender, region'
                             )

View(df2)

df3 <- fst_prepare_svydesign(svydesign = svy,
                              question = 'q11_3',
                              id = 'fsd_id',
                              model = 'ftb',
                              use_weights = FALSE,
                              add_cols = NULL
)

View(df3)

##############################
#### Demo part 2: Explore ####
##############################

fst_summarise(data = df,
              desc = 'All responses' # DEFAULT VALUE
              )

fst_pos(data = df)

fst_length_summary(data = df,
                   desc = 'All responses', # DEFAULT VALUE
                   incl_sentences = TRUE # DEFAULT VALUE
                   )


# IDENTIFICATION OF FREQUENT WORDS AND PHRASES
# Wordcloud
fst_wordcloud(data = df,
              pos_filter = NULL, # DEFAULT
              max = 100, # DEFAULT
              use_svydesign_weights = FALSE, # DEFAULT
              id = "", # DEFAULT
              svydesign = NULL, # DEFAULT
              use_column_weights = FALSE) # DEFAULT
dev.off()

fst_wordcloud(data = df,
              pos_filter = c("NOUN", "VERB"),
              max = 50, # Changed
              use_svydesign_weights = FALSE,
              id = "",
              svydesign = NULL,
              use_column_weights = TRUE # Changed
              )
dev.off()

fst_wordcloud(data = df3, # DF NEEDS TO NOT ALREADY HAVE WEIGHTS
              pos_filter = NULL,
              max = 100,
              use_svydesign_weights = TRUE, # changed
              id = "fsd_id", # Req'd
              svydesign = svy, # Changed
              use_column_weights = FALSE
              )

# Frequent Words Plots
fst_freq(data = df,
         number = 10, # DEFAULT
         norm = 'number_resp', # NOT DEFAULT
         pos_filter = NULL, # DEFAULT
         strict = TRUE, # DEFAULT
         name = NULL, # DEFAULT
         use_svydesign_weights = FALSE, # DEFAULT
         id = "", # DEFAULT
         svydesign = NULL, # DEFAULT
         use_column_weights = FALSE # DEFAULT
         )

fst_freq(data = df,
         use_column_weights = TRUE)

fst_ngrams(data = df,
           number = 10,
           ngrams = 1,
           norm = NULL,
           pos_filter = NULL,
           strict = TRUE,
           name = NULL,
           use_svydesign_weights = FALSE,
           id = "",
           svydesign = NULL,
           use_column_weights = FALSE
           )

fst_ngrams(data = df,
           ngrams = 2)

fst_ngrams(data = df,
           ngrams = 2,
           use_column_weights = TRUE)

################################
# Demo part 3: Concept Network #
################################

fst_concept_network(data = df,
                    concepts = 'köyhyys, nälänhätä, sota',
                    threshold = NULL, # DEFAULT VALUE
                    norm = "number_words", # DEFAULT
                    pos_filter = NULL, # DEFAULT
                    title = NULL # DEFAULT
                    )

##############################
### Demo part 4: Comparison ##
##############################

fst_summarise_compare(data = df,
                      field = 'gender',
                      exclude_nulls = 'FALSE', # DEFAULT VALUE
                      rename_nulls = 'null_data' # DEFAULT VALUE
                      )

fst_summarise_compare(data = df,
                      field = 'region',
                      exclude_nulls = 'FALSE', # DEFAULT VALUE
                      rename_nulls = 'No region known'
                      )

fst_pos_compare(data = df,
                field = 'gender',
                exclude_nulls = TRUE)

fst_length_compare(data = df,
                   field = 'gender',
                   exclude_nulls = TRUE)

fst_comparison_cloud(data = df,
                     field = 'gender',
                     exclude_nulls = TRUE
)
dev.off()

fst_comparison_cloud(data = df,
                     field = 'gender',
                     exclude_nulls = TRUE,
                     use_column_weights = TRUE)

fst_freq_compare(data = df,
                 field = 'gender',
                 exclude_nulls = TRUE,
                 norm = NULL)

fst_freq_compare(data = df,
                 field = 'gender',
                 exclude_nulls = TRUE,
                 norm = 'number_resp')

fst_freq_compare(data = df,
                 field = 'gender',
                 exclude_nulls = TRUE,
                 use_column_weights = TRUE,
                 title_size = 15)

fst_freq_compare(data = df3,
                 field = 'gender',
                 exclude_nulls = TRUE,
                 use_svydesign_weights = TRUE,
                 use_svydesign_field = TRUE,
                 id = 'fsd_id',
                 svydesign = svy)

fst_ngrams_compare(data = df3,
                   field = 'gender',
                   ngrams = 2,
                   exclude_nulls = TRUE,
                   use_svydesign_weights = TRUE,
                   use_svydesign_field = TRUE,
                   id = 'fsd_id',
                   svydesign = svy,
                   title_size = 15,
                   subtitle_size = 10)

# Comparison Concept Network
fst_concept_network_compare(data = df3,
                            concepts = 'köyhyys, nälänhätä, sota, ilmastonmuutos',
                            field = 'gender',
                            norm = NULL,
                            threshold = NULL,
                            pos_filter = NULL,
                            use_svydesign_field = TRUE, # NOTE THIS
                            id = "fsd_id",
                            svydesign = svy,
                            exclude_nulls = TRUE,
                            title_size = 20,
                            subtitle_size = 15)


##############################
#### Demo part 5: R Shiny ####
##############################

runDemo()
