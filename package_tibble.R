
# Pacote tibble - Tidyverse ---------------------------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco --------------------------------------------------------------------------------------------------------
# Data: 10/03/2022 ------------------------------------------------------------------------------------------------------------------------
# Fonte: Curso R --------------------------------------------------------------------------------------------------------------------------

# Tibbles ---------------------------------------------------------------------------------------------------------------------------------

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

## Além de nos possibilitar a criar tibbles, o pacote {tibble} possui algumas funções 
## úteis para manipularmos esses objetos:

## - add_row() e add_column(): para adicionar linhas e colunas a uma tibble;

## - rowid_to_column(): cria uma coluna com um id numérico e sequencial para 
## as linhas, começando de 1.

mtcars %>% 
  rowid_to_column() %>% 
  head(10)

## - has_rownames(): verifica se um data frame possui linhas nomeadas.

## - remove_rownames(): remove o nome das linhas de um data frame.

## - rownames_to_column(): transforma o nome das linhas em uma coluna.

## - column_to_rownames(): transforma uma coluna em nomes das linhas.

rownames_to_column(mtcars, var = "modelo_do_carro") # Nomeia uma coluna com nomes
remove_rownames(mtcars) # Remove todas as linhas com nomes
has_rownames(mtcars) # Retorna TRUE ou FALSE

state_dat <- data.frame(state.name, state.area, state.center, state.division)
column_to_rownames(state_dat, 'state.name') # Transforma uma coluna em nomes

