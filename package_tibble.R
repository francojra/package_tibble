
# Pacote tibble - Tidyverse -----------------------------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 10/03/2022 -------------------------------------------------------------------------------------------------------------------------
# Fonte: Curso R ---------------------------------------------------------------------------------------------------------------------------

# Tibbles ----------------------------------------------------------------------------------------------------------------------------------

## Tibbles são data frames com ajustes que as deixam mais amigáveis a nós cientistas de dados. 
## Elas são parte do pacote {tibble}. Assim, para começar a usá-las, instale e carregue o pacote.

# install.packages("tibble")
library(tibble)

## Há duas formas de criar uma tibble. A primeira é transformar um data frame em tibble 
## utilizando a função as_tibble().

as_tibble(mtcars)

## Veja que, por padrão, apenas as dez primeiras linhas da base são apresentadas. 
## Além disso, colunas que não couberem na largura da tela serão omitidas. 
##  Também são apresentadas a dimensão da tabela e as classes de cada coluna. 
## Compare a diferença de impressão com relação a um data frame.

mtcars

## Veja também que, ao contrário dos data frames, tibbles não utilizam nome nas linhas.

## A segunda forma de criar uma tibble é a partir de vetores individuais, utilizando a 
## função tibble().

tibble(
  coluna1 = c("a", "b", "c", "d"),
  coluna2 = 1:4,
  coluna3 = coluna2 ^ 2,
  coluna4 = 0
)

## Observamos pelo código acima que:

## - podemos criar uma coluna a partir de uma função de colunas anteriores (a coluna3 é 
## uma função da coluna2);

## - se passarmos um vetor de tamanho 1 a uma das colunas, esse vetor será reciclado, 
## igualando-se ao número de linhas da tibble (o 0 na coluna4 é transformado em c(0, 0, 0, 0)).

## Uma outra diferença entre data frames e tibbles está no subsetting. Tibbles nunca 
## fazem correspondência parcial. Tibbles retornam NULL e um aviso quando você tenta 
## selecionar uma coluna que não existe.

mtcars$dis # Selecionando colunas em um data.frame

mtcars_tibble <- as_tibble(mtcars) # Em tibbles isso não funciona
mtcars_tibble$dis
