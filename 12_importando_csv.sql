-- Na planilha, as colunas devem ficar na mesma ordem em que as colunas no comando a seguir.

COPY funcionario(
	funcionario_codigo,
	funcionario_nome,
	funcionario_situacao,
	funcionario_comissao,
	funcionario_cargo,
	data_criacao, 
	data_atualizacao) 
FROM 'C:\Users\Pichau\Desktop\postgresql\funcionario.csv'
WITH DELIMITER ',' 
CSV HEADER;

select * from funcionario;