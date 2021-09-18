-- ################################################################ Funções de string ################################################################

-- https://www.postgresql.org/docs/9.1/functions-string.html

-- [OUT]: "VI000000S CARVALHO"
select overlay(funcionario_nome placing '000000' from 3 for 5) from funcionario where id = 1;

-- [OUT]: "NICIU"
select substring(funcionario_nome from 3 for 5) from funcionario where id = 1; 

-- [OUT]: 5
select position('CIUS' in funcionario_nome) from funcionario where id = 1;

-- ################################################################ Funções de datas ################################################################

-- https://www.postgresql.org/docs/9.1/functions-datetime.html

-- Verificando o tipo da formatação atual da data:
show datestyle; -- [OUT]: "ISO, DMY"

-- DMY = Day/Month/Year

-- Alterando para o padrão brasileiro:
alter database livro set datestyle to iso, dmy; -- Via shell: set datestyle to iso, dmy;

-- Verificando a idade a partir de uma data:
select age(timestamp '04/11/1996');

-- Calculando a idade a partir de um intervalo:
select age(timestamp '07/05/2016', timestamp '12/05/2007');

-- Extraindo o ano da coluna data_criacao.
select extract(year from data_criacao) from funcionario where id = 1;

-- ################################################################ Funções de formatação ################################################################

-- https://www.postgresql.org/docs/9.1/functions-formatting.html