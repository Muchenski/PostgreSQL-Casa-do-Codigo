/*
######################################################################################################
	Índices ordenam os registros a partir da coluna em que foi criado.
	Assim, consultas que utilizam-o como critério de busca são mais eficientes.
	
	Vantagem dos índices: 
		Consultas mais rápidas.
	
	Desvantagens dos índices:
		Ao inserir, atualizar, ou excluir registros, estes terão de ser reorganizados visando
		a ordenação dos índices presentes nas colunas, o que pode causar uma pequena lentidão.
	
	Dicas:
		Criar índices em colunas que serão constantemente utilizadas em consultas.
	
######################################################################################################
	
	Tipos de índices:
	
	B-tree:
		Índice padrão, mais indicado para situações de consultas comuns.
		São utilizados em operadores de comparação, 'in' e 'between'.
	
	Hash:
		É útil apenas para operadores de igualdade.
		Não oferece transações seguras, e não tem performance melhor que o B-tree.
		Seu tamanho e tempo de construção são muito piores.
		Não é recomendado utilizar este tipo de índice.
		
	Concorrentes:
		Ao criar um índice, a tabela fica bloqueada para inserção até que o índice seja totalmente construído.
		Se criarmos um índice em uma tabela muito grande, isso poderá bloquear a tabela por muito tempo.
		Assim, as ações de inserção, atualização e até exclusão, podem ficar bloqueadas durante um período, afetando
		diretamente a aplicação.
		Para este tipo de situação, existem os índices concorrentes, que não realizam bloqueio da tabela, já que a criação
		dos índices ocorre em uma thread separada.
		
	Multicolunas:
		Os índices de uma única coluna não serão úteis para melhorar a performance de consultas onde serão comparadas mais de uma coluna.
		Para estas situações, podemos criar índices multicolunas.
		
	Índices únicos:
		Transformam os valores de uma determinada coluna exclusivos.
*/

-- B-tree.
create index idx_cargo on funcionario(funcionario_cargo);

-- Hash.
create index idx_codigo on funcionario using hash(funcionario_codigo);

-- Concorrentes.
create index concurrently idx_nome on funcionario using btree(funcionario_nome);

-- Multicolunas.
create index idx_funcionario_id_codigo on funcionario(id, funcionario_codigo);
-- Exemplo de consulta em que o índice multicolunas se faz útil:
select * from funcionario where id > 10 and funcionario_codigo < '1000';

-- Únicos
create unique index idx_unique_codigo on funcionario(funcionario_codigo);

-- Dropando index.
drop index idx_cargo;

--####################################################################################################

/*
	O banco de dados atualiza o índice automaticamente quando há uma alteração.
	A otimização nas consultas é realizada quando ele julgar mais eficiente do que a busca linha a linha.
	O PostgreSQL realiza uma análise para ver o método mais eficiente, de acordo com estatísticas retiradas
	da tabela.
	É muito importante utilizarmos o comando 'analyze' de maneira periódica.
	Este comando coleta estatísticas e armazena os resultados na tabela 'pg_statistic'.
*/

-- Análisando todas tabelas do banco.
analyze	verbose;

-- Analisando uma tabela específica.
analyze	verbose funcionario;

-- Analisando uma coluna específica.
analyze	verbose funcionario(funcionario_cargo);

--####################################################################################################

/*
	Mesmo realizando o comando analyse constantemente, com o tempo, alguns índices podem perder o desempenho e
	se tornar ineficiente. 
	Caso isso ocorra, podemos realizar a reindexação do índice.
	Ela refará o processo de indexar os registros de onde ele for criado, e irá performar melhor.
*/

reindex	table funcionario;