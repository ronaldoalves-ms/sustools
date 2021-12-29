#' Codificação de Codificações Sensíveis à Atenção Primária em Saúde
#'
#' \code{stop_hospitalization} é uma função de classificação de códigos CID-10 segundo a lista brasileira de condições sensíveis à atenção primária em saúde. Esta função cria um vetor de códigos identificadores (stop_code), cuja estrutura compreende os diversos níveis da classificação de condições sensíveis à atenção primária em saúde.
#'
#' @param dados Um data frame contendo os dados de interesse.
#'
#' @param var_nome Um vetor de caracteres contendo os códigos da CID-10.
#'
#' @return A função retorna um data frame enriquecido com a variável "stop_code".
#'
#' @references Alfradique ME, Bonolo PF, Dourado I, et al. Internações por condições sensíveis à atenção primária: a construção da lista brasileira como ferramenta para medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cadernos de Saúde Pública, 25(6), jun 2009.\url{https://doi.org/10.1590/S0102-311X2009000600016}
#'
#' @author Ronaldo Fernandes Santos Alves. Fundação Oswaldo Cruz, Instituto de Comunicação e Informação Científica e Tecnológica em Saúde.
#'
#' @examples
#' library(sustools)
#' dados <- stop_hospitalization(dados, dados$var_nome)
#'
#' @export



# PACOTES INSTALADOS PARALELAMENTE

#usethis::use_package("magrittr", type = "Imports")
#usethis::use_package("dplyr", type = "Imports")
#usethis::use_package("stringr", type = "Imports")
#usethis::use_pipe(export = TRUE)


stop_hospitalization <- function(dados, var_nome){

  dados <- dados %>%

    dplyr::mutate(stop_code = stringr::str_remove_all(var_nome, "[^[:alnum:]]")) %>%
    dplyr::mutate(stop_code = stringr::str_to_upper(var_nome))


  dados <- dados %>%

    dplyr::mutate(
      stop_code = dplyr::case_when(
        stringr::str_detect(var_nome, "A170|^A19|^A3[3-7]|^A95|^B0[5-6]|^B16|^B26|G000") ~ "H01",
        stringr::str_detect(var_nome, "^A1[5-6]|A17[1-9]|^A18|^I0[0-2]|^A5[1-3]|^B5[0-4]|^B77") ~ "H02",
        stringr::str_detect(var_nome, "^A0[0-9]|^E86") ~ "H03",
        stringr::str_detect(var_nome, "^D50") ~ "H04",
        stringr::str_detect(var_nome, "^E4[0-6]|^E5[0-9]|^E6[0-4]") ~ "H05",
        stringr::str_detect(var_nome, "^H66|^J0[0-3]|^J06|^J31") ~ "H06",
        stringr::str_detect(var_nome, "^J1[3-4]|J15[3-4]|J15[8-9]|J181") ~ "H07",
        stringr::str_detect(var_nome, "^J4[5-6]") ~ "H08",
        stringr::str_detect(var_nome, "^J2[0-1]|^J4[0-4]|^J47") ~ "H09",
        stringr::str_detect(var_nome, "^I1[0-1]") ~ "H10",
        stringr::str_detect(var_nome, "^I20") ~ "H11",
        stringr::str_detect(var_nome, "^I50|^J81") ~ "H12",
        stringr::str_detect(var_nome, "^I6[3-7]|^I69|^G4[5-6]") ~ "H13",
        stringr::str_detect(var_nome, "^E1[0-4]") ~ "H14",
        stringr::str_detect(var_nome, "^G4[0-1]") ~ "H15",
        stringr::str_detect(var_nome, "^N1[0-2]|^N30|^N34|N390") ~ "H16",
        stringr::str_detect(var_nome, "^A46|^L0[1-4]|^L08") ~ "H17",
        stringr::str_detect(var_nome, "^N7[0-3]|^N7[5-6]") ~ "H18",
        stringr::str_detect(var_nome, "^K2[5-8]|K920|K921|K922") ~ "H19",
        stringr::str_detect(var_nome, "^O23|^A50|P350") ~ "H20",

        TRUE ~ "H00"))

}
