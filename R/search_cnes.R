#' Consulta de Estabelecimentos de Saúde no Site do Ministério da Saúde
#'
#' \code{search_cnes} é uma função de busca de informações básicas dos estabelecimentos de saúde do Brasil.
#'
#' @param nu_cnes Um vetor de códigos CNES.
#'
#' @return A função retorna um dataframe com informações básicas dos estabelecimentos de saúde.
#'
#' @references Site do Ministério da Saúde para consulta de estabelecimentos de saúde.\url{http://cnes.datasus.gov.br/pages/estabelecimentos/consulta.jsp}
#'
#' @author Ronaldo Fernandes Santos Alves. Fundação Oswaldo Cruz, Instituto de Comunicação e Informação Científica e Tecnológica em Saúde.
#'
#' @examples
#' library(sustools)
#' nu_cnes <- c(2269783, 2269880, 2270021, 2270390, 2708353)
#' dados <- search_cnes(nu_cnes)
#'
#' @export


# PACOTES INSTALADOS PARALELAMENTE

#usethis::use_package("magrittr", type = "Imports")
#usethis::use_package("dplyr", type = "Imports")
#usethis::use_package("stringr", type = "Imports")
#usethis::use_package("httr", type = "Imports")
#usethis::use_package("purrr", type = "Imports")
#usethis::use_pipe(export = TRUE)


search_cnes <-
  function(nu_cnes){

    nu_cnes <- as.integer(stringr::str_remove_all(nu_cnes, "[^[:digit:]]"))
    nu_cnes <- stringr::str_pad(nu_cnes, width = 7, side = "left", pad = 0L)

    ls_url <- paste0("http://cnes.datasus.gov.br/services/estabelecimentos?cnes=", nu_cnes)

    df_scrap <- NULL

    for(i in seq_along(ls_url)){

      skip_to_next <- FALSE

      r <- tryCatch({

        httr::GET(ls_url[i],
                  httr::add_headers("Host" = "cnes.datasus.gov.br",
                                    "Referer" = "http://cnes.datasus.gov.br/pages/estabelecimentos/consulta.jsp",
                                    "Connection" = "keep-alive",
                                    "Content-Type" = "application/json;charset=UTF-8",
                                    "Accept" = "application/json, text/plain, */*"),
                  httr::timeout(1200))},
        error = function(e){

          skip_to_next <<- TRUE})

      if(skip_to_next){

        next

      } else{

        df <- httr::content(r) %>% purrr::flatten_dfc()

        df_scrap <- dplyr::bind_rows(df_scrap, df)

        message(paste0("Done!", " Name: ", nu_cnes[i], " Time: ", Sys.time()))

        rm(r, df)

      }

    }

    return(df_scrap)

  }
