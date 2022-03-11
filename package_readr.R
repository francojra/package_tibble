
# Pacote readr - Tidyverse -----------------------------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 08/03/2022 -------------------------------------------------------------------------------------------------------------------------
# Fonte: Curso R ---------------------------------------------------------------------------------------------------------------------------

# O pacote readr ---------------------------------------------------------------------------------------------------------------------------

## O pacote {readr}do tidyverse é utilizado para importar arquivos de texto, como .txt ou .csv, 
## para o R. Para carregá-lo, rode o código:

library(readr)

## O {readr} transforma arquivos de textos em tibbles usando as funções:

## - read_csv(): para arquivos separados por vírgula.

## - read_tsv(): para arquivos separados por tabulação.

## - read_delim(): para arquivos separados por um delimitador genérico. O argumento delim= indica qual 
## caracter separa cada coluna no arquivo de texto.

## - read_table(): para arquivos de texto tabular com colunas separadas por espaço.

## - read_fwf(): para arquivos compactos que devem ter a largura de cada coluna especificada.

## - read_log(): para arquivos padrões de log.

## Vamos mostrar na próxima seção como importar as extensões mais comuns: .csv e .txt.

# Lendo arquivos de texto ------------------------------------------------------------------------------------------------------------------

## Primeiro, vamos ler a base em formato .csv

imdb_csv <- read_csv(file = "imdb.csv")

## A mensagem retornada pela função indica qual classe foi atribuída para cada coluna. Repare que 
## o argumento file= representa o caminho até o arquivo. Se o arquivo a ser lido não estiver 
## no diretório de trabalho da sua sessão, você precisa especificar o caminho até o arquivo.

# Se o arquivo estiver dentro de outra pasta e você não estiver no diretório. Deve copiar o 
# caminho da pasta do diretório.

imdb_csv <- read_csv(file = "C:/Users/jeann/Documents/pRaticando-Softawer-R/package_readr/imdb.csv")

## A maioria das funções de leitura do {readr} possuem argumentos muito úteis para resolver 
## problemas de importação:

## col_names=: indica se a primeira linha da base contém ou não o nome das colunas. Também pode 
## ser utilizado para (re)nomear colunas.

## col_types=: caso alguma coluna seja importada com a classe errada (uma coluna de números 
## foi importada como texto, por exemplo), você pode usar esse argumento para especificar 
## a classe das colunas.

## locale=: útil para tratar problema de encoding.

## skip=: pula linhas no começo do arquivo antes de iniciar a importação. Útil para 
## quando o arquivo a ser importado vem com metadados ou qualquer tipo de texto nas 
## primeiras linhas, antes da base.

## na=: indica quais strings deverão ser considaras NA na hora da importação.

## Em alguns países, como o Brasil, as vírgulas são utilizadas para separar as
## casas decimais dos números, inviabilizando o uso de arquivos .csv. 

##  Para importar bases de arquivos separados por ponto-e-vírgula no R, 
## basta usar a função read_csv2().

imdb_csv2 <- read_csv2("imdb2.csv")

## Arquivos .txt em geral podem ser lidos com a função read_delim(). Além do caminho 
## até o arquivo, você também precisa indicar qual é o caractere utilizado para 
## separar as colunas da base. Um arquivo separado por tabulação, por exemplo, pode 
## ser lido utilizando a o código abaixo. O código \t é uma forma textual de 
## representar a tecla TAB.

imdb_txt <- read_delim("imdb.txt", delim = "\t")

## Repare que a sintaxe é igual a da função read_csv(). Em geral, as funções 
## de importação do {tidyverse} terão sintaxe e comportamento muito parecidos.

# Locale() ---------------------------------------------------------------------------------------------------------------------------------

## Muitas funções de importação e formatação possuem um argumento locale. Esse argumento 
## é utilizado para definir opções de formatação próprias de uma certa localidade, como 
## idioma, formato de data e hora, fuso horário, separador de decimal e milhar ou encoding.

## O pacote {readr} possui uma função chamada locale(), que pode ser utilizada para 
## definir todos esses atributos. Para saber quais são os padrões atualmente definidos 
## na sua sessão, basta rodar:

locale()

## Em geral, teremos padrões norte-americanos. Se quisermos que os nomes de dias e meses
## fiquem em português, podemos fazer:

locale(date_names = "pt")

## Ou trocar o separador de decimal de ponto para vírgula, caso a base a ser importada 
## esteja nesse formato.

locale(decimal_mark = ",")

## A função locale() deve ser utilizada dentro das funções read_(), no argumento locale. 
## Uma utilização muito comum é a definição do encoding do arquivo. O encoding se refere 
## a como o computador traduz os caracteres que vemos na tela para os valores binários 
## que ele utiliza internamente. Existem vários tipos de encoding e isso é um problema 
## principalmente porque o Windows utiliza um encoding diferente do Linux/Mac. 
## Você saberá que tem um problema de encoding quando letras com acento ou outros 
## caracteres especiais ficarem desconfigurados após importar uma base para o R.

frase_com_acentos <- "Você comerá uma maçã amanhã à tarde"
Encoding(frase_com_acentos) # latin1 é um dos padrões que funcionam no Windows.

Encoding(frase_com_acentos) <-  "UTF-8" # Forçando um novo encoding.
frase_com_acentos

Encoding(frase_com_acentos) <-  "latin1" # Retornando ao ecoding do windows.
frase_com_acentos

## Quando estivermos enfrentando esse problema, devemos dizer à função read_() qual 
## o encoding deve ser utilizado no arquivo.

read_csv("base_que_veio_do_windows.csv", locale = locale(encoding = "latin1"))

## O latin1 é apenas um dos encodings que podem funcionar em arquivos do Windows. 
## Outras sugestões são: windows-1250, windows-1252, ISO-8859-2 e ISO-8859-1. 
## Se você estiver lendo um arquivo criado no Linux/Mac no Windows, basta usar 
## o encoding UTF-8.

# Parseando valores ------------------------------------------------------------------------------------------------------------------------

## O pacote {readr} possui algumas funções muito úteis para parsear valores. 
## Parsear é um termo muito utilizado em programação e tem o sentido de arrumar 
## ou formatar. Se estamos parseando um número, por exemplo, estamos pegando um 
## texto que é muito parecido com um número e o transforando em um número de fato.

parse_number(c("5", "5.0", "5,0", "R$5.00", "5 a"))

## Veja que podemos usar o argumento locale para especificar coordenadas para o parseamento

parse_number("5,0", locale = locale(decimal_mark = ","))

## ou o idioma usado em datas

parse_date("01/June/2010", format = "%d/%B/%Y") # Inglês

parse_date("01/Junho/2010", format = "%d/%B/%Y", locale = locale(date_names = "pt")) # Português

## Você também pode especificar NAs utilizando o argumento na.

parse_number(c("5", "5.0", "5,0", "R$5.00", "5 a"), na = "5 a")

## Outras funções de parseamento úteis são:

## - readr::parse_integer(), para parsear números inteiros.
## - readr::parse_character(), para parsear strings
## - readr::parse_date(), readr::parse_time(), readr::parse_datetime()
## para parsear datas, horas e data/horas.

## Todas essas funções são utilizadas nas colunas de uma base quando utilizamos as 
## funções de importação do {readr}. Assim, se algum valor foi modificado incorretamente 
## durante a importação, você pode testar importar tudo como texto (character) e usar 
## essas funções para reproduzir a transformação que o {readr} fez.

# Escrevendo arquivos de texto -------------------------------------------------------------------------------------------------------------

## Para a maioria das funções read_, existe uma respectiva função write_. Essas 
## funções servem para salvar bases em um formato específico de arquivo. Além do 
## caminho/nome do arquivo a ser criado, você também precisa passar o objeto que 
## será escrito. Para o arquivo criado funcionar corretamente, você precisa especificar 
## a extensão correta no nome do arquivo.

mtcars # Primeiro indica o nome dos dados
write_csv(x = mtcars, path = "mtcars.csv") # Arquivo .csv

write_delim(x = mtcars, path = "mtcars.txt", delim = "\t") # Base separada por tabulação

# Arquivos .rds ---------------------------------------------------------------------------------------------------------------------------

## A linguagem R tem uma extensão própria de arquivos binários chamada RDS ou .rds. 
## Essa extensão pode ser utilizada para guarda qualquer tipo de objeto do R, inclusive 
## bases de dados. Temos duas principais vantagens ao utilizarmos essa extensão para
## salvarvamos as nossas bases:

## - ele salva as classes especificadas para as colunas;

## - ele pode ser compactado, gerando arquivos muito menores.

## A desvantagem é que ele só poderá ser lido dentro do R.
## Para criar um arquivo .rds, utilize a função write_rds().

write_rds(mtcars, path = "mtcars.rds", compress = "gz")

## O argumento compress é opcional e indica qual o tipo de compactação deve 
## ser feito. O padrão é não compactar.

## Para ler um arquivo .rds de volta para o R, utilizamos a função read_rds(). 
## Repare que essa função não possui outros argumentos, pois o objeto importado
## será exatamente igual ao objeto que foi gravado no arquivo.

imdb_rds <- read_rds(file = "imdb.rds")
View(imdb_rds) # Visualizar planilha
