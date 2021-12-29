#' Codificação de Causas de Óbitos Evitáveis na Infância
#'
#' \code{stop_childdeath} é uma função de codificação de causas de óbitos evitáveis em crianças menores de 5 anos de idade. A função cria um vetor de códigos identificadores (stop_code), cuja estrutura compreende variados níveis hierárquicos de classificação de causas de óbitos evitáveis.
#'
#' @param dados Um data frame contendo os dados de interesse.
#'
#' @param var_nome Um vetor de caracteres contendo os códigos da CID-10.
#'
#' @return A função retorna um data frame enriquecido com a variável "stop_code".
#'
#' @references Malta DC, Duarte EC, Almeida MF, et al. Lista de causas de mortes evitáveis por intervenções do Sistema Único de Saúde do Brasil. Epidemiologia e Serviços de Saúde, 16(4):233-244, out-dez 2007.\url{http://dx.doi.org/10.5123/S1679-49742007000400002}
#' @references Malta DC, Sardinha LMV, Moura L, et al. Atualização da lista de causas de mortes evitáveis por intervenções do Sistema Único de Saúde do Brasil. Epidemiologia e Serviços de Saúde, 19(2):173-176, abr-jun 2010.\url{http://dx.doi.org/10.5123/S1679-49742010000200010}
#'
#' @author Ronaldo Fernandes Santos Alves. Fundação Oswaldo Cruz, Instituto de Comunicação e Informação Científica e Tecnológica em Saúde.
#'
#' @examples
#' library(sustools)
#' dados <- stop_childdeath(dados, dados$var_nome)
#'
#' @export


# PACOTES INSTALADOS PARALELAMENTE

#usethis::use_package("magrittr", type = "Imports")
#usethis::use_package("dplyr", type = "Imports")
#usethis::use_package("stringr", type = "Imports")
#usethis::use_pipe(export = TRUE)


stop_childdeath <- function(dados, var_nome){

  dados <- dados %>%

    dplyr::mutate(stop_code = stringr::str_remove_all(var_nome, "[^[:alnum:]]")) %>%
    dplyr::mutate(stop_code = stringr::str_to_upper(var_nome))


  dados <- dados %>%

    dplyr::mutate(
      stop_code = dplyr::case_when(
        stringr::str_detect(var_nome, "^A17") ~ "01_11_0_003",
        stringr::str_detect(var_nome, "^A19") ~ "01_11_0_004",
        stringr::str_detect(var_nome, "^A33") ~ "01_11_0_005",
        stringr::str_detect(var_nome, "^A35") ~ "01_11_0_006",
        stringr::str_detect(var_nome, "^A36") ~ "01_11_0_007",
        stringr::str_detect(var_nome, "^A37") ~ "01_11_0_008",
        stringr::str_detect(var_nome, "^A80") ~ "01_11_0_009",
        stringr::str_detect(var_nome, "^B05") ~ "01_11_0_010",
        stringr::str_detect(var_nome, "^B06") ~ "01_11_0_011",
        stringr::str_detect(var_nome, "^B16") ~ "01_11_0_012",
        stringr::str_detect(var_nome, "^B26") ~ "01_11_0_013",
        stringr::str_detect(var_nome, "G000") ~ "01_11_0_014",
        stringr::str_detect(var_nome, "P350") ~ "01_11_0_015",
        stringr::str_detect(var_nome, "P353") ~ "01_11_0_016",

        stringr::str_detect(var_nome, "^A50") ~ "01_12_1_019",
        stringr::str_detect(var_nome, "^B2[0-4]") ~ "01_12_1_020",
        stringr::str_detect(var_nome, "^P02[2-3,7-9]") ~ "01_12_1_021",
        stringr::str_detect(var_nome, "^P0[0,4]") ~ "01_12_1_022",
        stringr::str_detect(var_nome, "^P01") ~ "01_12_1_023",
        stringr::str_detect(var_nome, "^P05") ~ "01_12_1_024",
        stringr::str_detect(var_nome, "^P07") ~ "01_12_1_025",
        stringr::str_detect(var_nome, "P220") ~ "01_12_1_026",
        stringr::str_detect(var_nome, "^P26") ~ "01_12_1_027",
        stringr::str_detect(var_nome, "^P52") ~ "01_12_1_028",
        stringr::str_detect(var_nome, "P55[0-1]") ~ "01_12_1_029",
        stringr::str_detect(var_nome, "P55[8-9]|^P5[6-7]") ~ "01_12_1_030",
        stringr::str_detect(var_nome, "^P77") ~ "01_12_1_031",

        stringr::str_detect(var_nome, "P02[0-1]") ~ "01_12_2_033",
        stringr::str_detect(var_nome, "P02[4-6]") ~ "01_12_2_034",
        stringr::str_detect(var_nome, "^P03") ~ "01_12_2_035",
        stringr::str_detect(var_nome, "^P08") ~ "01_12_2_036",
        stringr::str_detect(var_nome, "^P1[0-5]") ~ "01_12_2_037",
        stringr::str_detect(var_nome, "^P2[0-1]") ~ "01_12_2_038",
        stringr::str_detect(var_nome, "P24[0-2,8-9]") ~ "01_12_2_039",

        stringr::str_detect(var_nome, "P22[1,8-9]|^P2[3,5,7-8]") ~ "01_12_3_041",
        stringr::str_detect(var_nome, "P35[1-2,4-9]|^P3[6-9]") ~ "01_12_3_042",
        stringr::str_detect(var_nome, "^P5[0-1,3-4]") ~ "01_12_3_043",
        stringr::str_detect(var_nome, "^P5[8-9]") ~ "01_12_3_044",
        stringr::str_detect(var_nome, "^P7[0-4]") ~ "01_12_3_045",
        stringr::str_detect(var_nome, "^P6[0-1]") ~ "01_12_3_046",
        stringr::str_detect(var_nome, "^P7[5-6,8]") ~ "01_12_3_047",
        stringr::str_detect(var_nome, "^P8[0-3]") ~ "01_12_3_048",
        stringr::str_detect(var_nome, "^P9[0-4]|P96[0-8]") ~ "01_12_3_049",

        stringr::str_detect(var_nome, "^A15") ~ "01_13_0_051",
        stringr::str_detect(var_nome, "^A16") ~ "01_13_0_052",
        stringr::str_detect(var_nome, "^A18") ~ "01_13_0_053",
        stringr::str_detect(var_nome, "G00[1-9]|^G03") ~ "01_13_0_054",
        stringr::str_detect(var_nome, "^J0[0-6]") ~ "01_13_0_055",
        stringr::str_detect(var_nome, "^J1[2-8]") ~ "01_13_0_056",
        stringr::str_detect(var_nome, "^J2[0-2]") ~ "01_13_0_057",
        stringr::str_detect(var_nome, "J384") ~ "01_13_0_058",
        stringr::str_detect(var_nome, "^J4[0-2,5-7]") ~ "01_13_0_058",
        stringr::str_detect(var_nome, "^J6[8-9]") ~ "01_13_0_060",
        stringr::str_detect(var_nome, "^A7[0-4]") ~ "01_13_0_061",
        stringr::str_detect(var_nome, "^A3[0-2,8-9]|^A4[0-1,6,9]") ~ "01_13_0_062",
        stringr::str_detect(var_nome, "E03[0-1]") ~ "01_13_0_063",
        stringr::str_detect(var_nome, "^E1[0-4]") ~ "01_13_0_064",
        stringr::str_detect(var_nome, "E700") ~ "01_13_0_065",
        stringr::str_detect(var_nome, "E730") ~ "01_13_0_066",
        stringr::str_detect(var_nome, "^G4[0-1]") ~ "01_13_0_067",
        stringr::str_detect(var_nome, "^Q90") ~ "01_13_0_068",
        stringr::str_detect(var_nome, "N390") ~ "01_13_0_069",
        stringr::str_detect(var_nome, "^I0[0-9]") ~ "01_13_0_070",

        stringr::str_detect(var_nome, "^A0[0-9]") ~ "01_14_0_072",
        stringr::str_detect(var_nome, "^A2[0-8]") ~ "01_14_0_073",
        stringr::str_detect(var_nome, "^A9[0-9]") ~ "01_14_0_074",
        stringr::str_detect(var_nome, "^A7[5-9]") ~ "01_14_0_075",
        stringr::str_detect(var_nome, "^A82") ~ "01_14_0_076",
        stringr::str_detect(var_nome, "^B5[0-9]|^B6[0-4]") ~ "01_14_0_077",
        stringr::str_detect(var_nome, "^B6[5-9]|^B7|^B8[0-3]") ~ "01_14_0_078",
        stringr::str_detect(var_nome, "^B99") ~ "01_14_0_079",
        stringr::str_detect(var_nome, "^D5[0-3]") ~ "01_14_0_080",
        stringr::str_detect(var_nome, "^E4[0-9]|^E5[0-9]|^E6[0-4]") ~ "01_14_0_081",
        stringr::str_detect(var_nome, "^E86") ~ "01_14_0_082",
        stringr::str_detect(var_nome, "^V") ~ "01_14_0_083",
        stringr::str_detect(var_nome, "^X4[0-4]") ~ "01_14_0_084",
        stringr::str_detect(var_nome, "^X4[5-9]") ~ "01_14_0_085",
        stringr::str_detect(var_nome, "^R95") ~ "01_14_0_086",
        stringr::str_detect(var_nome, "^W[0-1]") ~ "01_14_0_087",
        stringr::str_detect(var_nome, "^X0[0-9]") ~ "01_14_0_088",
        stringr::str_detect(var_nome, "^X3[0-9]") ~ "01_14_0_089",
        stringr::str_detect(var_nome, "^W6[5-9]|^W7[0-4]") ~ "01_14_0_090",
        stringr::str_detect(var_nome, "^W7[5-9]|^W8[0-4]") ~ "01_14_0_091",
        stringr::str_detect(var_nome, "^W8[5-9]|^W9") ~ "01_14_0_092",
        stringr::str_detect(var_nome, "^X8[5-9]|^X9|^Y0") ~ "01_14_0_093",
        stringr::str_detect(var_nome, "^Y[1-2]|^Y3[0-4]") ~ "01_14_0_094",
        stringr::str_detect(var_nome, "^W[2-4]") ~ "01_14_0_095",
        stringr::str_detect(var_nome, "^Y6") ~ "01_14_0_096",
        stringr::str_detect(var_nome, "^Y8[3-4]") ~ "01_14_0_097",
        stringr::str_detect(var_nome, "^Y[4-5]") ~ "01_14_0_098",

        stringr::str_detect(var_nome, "^R[0-8]|^R9[0-4,6-9]") ~ "99_99_0_100",
        stringr::str_detect(var_nome, "^P95") ~ "99_99_0_101",
        stringr::str_detect(var_nome, "P969") ~ "99_99_0_102",

        TRUE ~ "00_00_0_103"))

}
