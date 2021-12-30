
# sustools

<!-- badges: start -->
<!-- badges: end -->

O pacote **sustools** tem como objetivo fornecer recursos computacionais para rotinas de trabalho com dados do Sistema Único de Saúde (SUS).

O público-alvo do pacote **sustools** inclui gestores e técnicos das Secretarias Estaduais e Municipais de Saúde e do Ministério da Saúde, pesquisadores da área de epidemiologia e saúde pública e estudantes de graduação e pós-graduação de variados campos das ciências da saúde.

Atualmente, o pacote **sustools** reúne as quatro funções descritas abaixo:

- **search_cnes**: realiza consultas de estabelecimentos de saúde do SUS por meio do [site](http://cnes.datasus.gov.br/pages/estabelecimentos/consulta.jsp) do Ministério da Saúde, recuperando informações básicas dos estabelecimentos. Esta função é indicada para aplicação no Cadastro Nacional de Estabelecimentos de Saúde (CNES).

- **stop_birthdefect**: detecta e classifica códigos da CID-10 de acordo com a lista brasileira de anomalias congênitas prioritárias para vigilância do SUS ([Cardoso-dos-Santos, 2021](https://doi.org/10.1590/S1679-49742021000100030)). Esta função é indicada para aplicação no Sistema de Informações sobre Nascidos Vivos (Sinasc).

- **stop_hospitalization**: detecta e classifica códigos da CID-10 de acordo com a lista brasileira de internações por condições sensíveis à atenção primária em saúde ([Alfradique, 2009](https://doi.org/10.1590/S0102-311X2009000600016)). Esta função é indicada para aplicação no Sistema de Informações Hospitalares (SIH). 

- **stop_childdeath**: detecta e classifica códigos da CID-10 de acordo com a lista brasileira de causas de mortes evitáveis (em menores de 5 anos de idade) por intervenções do SUS ([Malta, 2007](http://dx.doi.org/10.5123/S1679-49742007000400002); [Malta, 2010](http://dx.doi.org/10.5123/S1679-49742010000200010)). Esta função é indicada para aplicação no Sistema de Informações sobre Mortalidade (SIM).

## Como instalar?

Este pacote pode ser instalado no R executando os códigos abaixo:

```r
install.packages("devtools")
devtools::install_github("ronaldoalves-ms/sustools")
```

## Como usar?

A função **search_cnes** possui um único argumento, *nu_cnes*, que especifica um vetor de códigos de estabelecimentos de saúde a serem consultados. As funções **stop_birthdefect**, **stop_hospitalization** e **stop_childdeath** possuem dois argumentos principais: (i) o argumento *dados* que especifica o data frame de interesse, (ii) o argumento *var_nome* que especifica a variável com os códigos da CID-10 a serem classificados. Veja exemplos simples de aplicação a seguir. 
``` r
library(sustools)

nu_cnes <- c(2269783, 2269880, 2270021, 2270390, 2708353)
df_cnes <- search_cnes(nu_cnes)

dados
df_sinasc <- stop_birthdefect(dados, dados$var_nome)
df_sih <- stop_hospitalization(dados, dados$var_nome)
df_sim <- stop_childdeath(dados, dados$var_nome)
```

A função **search_cnes** retorna um dataframe com informações básicas dos estabelecimentos de saúde. As funções **stop_birthdefect**, **stop_hospitalization** e **stop_childdeath** retornam um dataframe enriquecido com a variável "stop_code", cuja estrutura compreende os variados níveis das listas brasileiras de classificação -- veja o arquivo [stop_tables](https://github.com/ronaldoalves-ms/sustools/blob/master/data/stop_tables.xlsx)
para detalhes das classificações.

### Referências

Cardoso-dos-Santos AC, Medeiros-de-Souza AC, Bremm JM, Alves RFS, Araújo VEM, et al. Lista de anomalias congênitas prioritárias para vigilância no âmbito do Sistema de Informações sobre Nascidos Vivos do Brasil. Epidemiol Serv Saúde. 2021;30(1):e2020835. Disponível em: [Link](https://doi.org/10.1590/S1679-49742021000100030)

Alfradique ME, Bonolo PF, Dourado I, Lima-Costa MF, Macinko J, et al. Internações por condições sensíveis à atenção primária: a construção da lista brasileira como ferramenta para medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cad Saúde Pública. 2009;25(6):1337-1349. Disponível em: [Link](https://doi.org/10.1590/S0102-311X2009000600016)

Malta DC, Duarte EC, Almeida MF, Dias MAS, Neto OLM, et al. Lista de causas de mortes evitáveis por intervenções do Sistema Único de Saúde do Brasil. Epidemiol Serv Saúde. 2007;16(4):233-244. Disponível em: [Link](http://dx.doi.org/10.5123/S1679-49742007000400002)

Malta DC, Sardinha LMV, Moura L, et al. Atualização da lista de causas de mortes evitáveis por intervenções do Sistema Único de Saúde do Brasil. Epidemiol Serv Saúde. 2010;19(2):173-176. Disponível em: [Link](http://dx.doi.org/10.5123/S1679-49742010000200010)

### Dúvidas e sugestões

Crie uma [issue](https://github.com/ronaldoalves-ms/sustools/issues) no
projeto ou envie um e-mail para <ronaldo.alves@icict.fiocruz.br>
