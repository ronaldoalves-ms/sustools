## code to prepare `DATASET` dataset goes here

# usethis::use_data_raw()

library(tidyverse)
dados <- rio::import("http://www2.datasus.gov.br/cid10/V2008/downloads/CID10CSV.zip")
dados <- dados %>% select(CAT) %>% rename("var_nome" = "CAT")
# format(object.size(dados), "Kb") # 128.5 Kb
usethis::use_data(dados, overwrite = TRUE)
