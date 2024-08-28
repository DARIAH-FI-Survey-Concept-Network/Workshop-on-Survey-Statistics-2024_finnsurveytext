# Polish: 'polish-lfg', 'polish-pdb', 'polish-sz'
# Ukrainian: 'ukrainian-iu'
# Estonian: 'estonian-edt', 'estonian-ewt'
# Lithuanian: 'lithuanian-alksnis', 'lithuanian-hse',
# Latvian: 'latvian-lvtb'
# Finnish: 'finnish-ftb', 'finnish-tdt'
# https://cran.r-project.org/web/packages/udpipe/udpipe.pdf
# https://dariah-fi-survey-concept-network.github.io/finnsurveytext/articles/web_only/Extra-AnalysingOtherLanguages.html
udpipe::udpipe_download_model('ukrainian-iu')

fst_find_stopwords(language = 'pl')
# P	  'pl'		'stopwords-iso'
# U	  uk    'stopwords-iso'
# E	  et    'stopwords-iso'
# F 	fi    'nltk', 'snowball', 'stopwords-iso'
# Li	lt    'stopwords-iso'
# La	lv    'stopwords-iso'

# Do not run, placeholders
df <- fst_prepare(data = survey_data,                 # Reqd.
                  question = 'open-ended qn',         # Reqd
                  id = 'ID',                          # Reqd
                  model = 'polish-lfg',               # Reqd, default is a Finnish model
                  stopword_list = 'stopwords-iso',    # Reqd, default is 'nltk' which will error in non-Finnish
                  language = 'pl',                    # Reqd
                  weights ='weight',                  # Optional
                  add_cols = 'col1, col2',            # Optional
                  manual = FALSE,                     # DEFAULT
                  manual_list = ''                  # DEFAULT
)

df2 <- fst_prepare_svydesign(svydesign = survey,
                             question = 'oe_question',
                             id = 'ID',
                             model = 'estonian-edt',
                             language = 'et',
                             stopword_list = 'stopwords-iso',
                             use_weights = TRUE,
                             add_cols = 'gender, region'
)



