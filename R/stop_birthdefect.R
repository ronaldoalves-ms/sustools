#' Classificação de Anomalias Congênitas Prioritárias
#'
#' \code{stop_birthdefect} é uma função de classificação de códigos da CID-10 para fins de vigilância de anomalias congênitas no Brasil.
#'
#' @param dados Um data frame contendo os dados de interesse.
#'
#' @param var_nome Um vetor de caracteres contendo os códigos da CID-10.
#'
#' @return A função retorna um data frame enriquecido com variáveis classificatórias.
#'
#' @references Cardoso-dos-Santos AC, Medeiros-de-Souza AC, Bremm JM, Alves RFS, et al. Lista de anomalias congênitas prioritárias para vigilância no âmbito do Sistema de Informações sobre Nascidos Vivos do Brasil. Epidemiologia e Serviços de Saúde, 30(1):e2020835, 2021.\url{https://doi.org/10.1590/S1679-49742021000100030}
#'
#' @author Ronaldo Fernandes Santos Alves. Fundação Oswaldo Cruz, Instituto de Comunicação e Informação Científica e Tecnológica em Saúde.
#'
#' @examples
#' library(sustools)
#' dados <- stop_birthdefect(dados, dados$var_nome)
#'
#' @export


# PACOTES INSTALADOS PARALELAMENTE

#usethis::use_package("magrittr", type = "Imports")
#usethis::use_package("dplyr", type = "Imports")
#usethis::use_package("stringr", type = "Imports")
#usethis::use_pipe(export = TRUE)


stop_birthdefect <- function(dados, var_nome){

  dados <- dados %>%

    dplyr::mutate(code_class = stringr::str_remove_all(var_nome, "[^[:alnum:]]")) %>%
    dplyr::mutate(code_class = stringr::str_to_upper(var_nome)) %>%
    dplyr::mutate(IDANOMAL = dplyr::case_when(stringr::str_detect(var_nome, "Q") ~ 1, TRUE ~ 0)) %>%
    dplyr::mutate(MAINANOMAL = dplyr::case_when(stringr::str_detect(var_nome, "Q000|Q001|Q002|Q01|Q05|Q02|Q20|Q21|Q22|Q23|Q24|Q25|Q26|Q27|Q28|Q35|Q36|Q37|Q54|Q56|Q66|Q69|Q71|Q72|Q73|Q743|Q792|Q793|Q90") ~ 1, TRUE ~ 0))


  dados <- dados %>%

    dplyr::mutate(AC1 = dplyr::if_else(stringr::str_detect(code_class, "Q00[0-2]|Q01|Q05"), 1, 0)) %>% # DTN
    dplyr::mutate(AC2 = dplyr::if_else(stringr::str_detect(code_class, "Q02"), 1, 0)) %>% # MICROCEFALIA
    dplyr::mutate(AC3 = dplyr::if_else(stringr::str_detect(code_class, "Q2[0-8]"), 1, 0)) %>% # CHD
    dplyr::mutate(AC4 = dplyr::if_else(stringr::str_detect(code_class, "Q3[5-7]"), 1, 0)) %>% # OC
    dplyr::mutate(AC5 = dplyr::if_else(stringr::str_detect(code_class, "Q54|Q56"), 1, 0)) %>% # GENITAL
    dplyr::mutate(AC6 = dplyr::if_else(stringr::str_detect(code_class, "Q66|Q69|Q7[1-3]|Q743"), 1, 0)) %>% # LB
    dplyr::mutate(AC7 = dplyr::if_else(stringr::str_detect(code_class, "Q79[2-3]"), 1, 0)) %>% # AWD
    dplyr::mutate(AC8 = dplyr::if_else(stringr::str_detect(code_class, "Q90"), 1, 0)) %>% # SD
    dplyr::mutate(AC9 = dplyr::if_else(IDANOMAL == 1 & MAINANOMAL == 0, 1, 0)) # OUTROS

}
