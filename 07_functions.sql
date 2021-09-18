/* Funções com retornos podem ser utilizadas por meio de consultas. */

create or replace 
function retorna_nome_funcionario(func_id int)
returns text as
$$
/* Variáveis utilizadas no método para guardar os valores do select. */
declare
	nome text;
	situacao text;
begin
	select funcionario_nome, funcionario_situacao 
	into nome, situacao
	from funcionario
	where id = func_id;
	
	if situacao = 'A' then 
		return nome || ' Usuário Ativo ';
	elsif situacao = 'I' then
		return nome || ' Usuário Inativo ';
	else
		return nome || ' Usuário com status nulo ou inválido ';
	end if;
end
$$
language plpgsql;

/*
 Os $$ são usados para limitar o corpo da função, e para o banco de dados entender que
 tudo o que está dentro dos limites do cifrão duplo é código de uma única função.
*/

/* Utilizando a função: */
select retorna_nome_funcionario(1);

/*##################################################################################################*/

create or replace 
function retorna_valor_comissao(func_id int)
returns real as 
$$
declare
	valor_comissao real;
begin
	select funcionario_comissao
	into valor_comissao
	from funcionario
	where id = func_id;
	return valor_comissao;
end
$$
language plpgsql;

select retorna_valor_comissao(1);

/*##################################################################################################*/

/* Funções sem retorno são utilizadas para realizar rotinas internas no banco de dados. */

create or replace
function calcula_comissao(data_inicio timestamp, data_fim timestamp)
returns void as
$$
declare 
	total_comissao real := 0;
	porcentagem_comissao real := 0;
	
	/* Variável para armazenar os registros dos loops. */
	reg record;
	
	/* Cursor para buscar a porcentagem de comissão do funcionário. */
	cursor_porcentagem cursor(func_id int) is
	select retorna_valor_comissao(func_id);
	
begin
	/* Realiza um loop e busca todas vendas no período informado. */
	for reg in (
		select id, funcionario_id, venda_total from venda
		where data_criacao >= data_inicio and data_criacao <= data_fim and venda_situacao = 'A'
	)
	
	loop
		open cursor_porcentagem(reg.funcionario_id);
		/* Pegando o valor do cursor e inserindo na variável. */
		fetch cursor_porcentagem into porcentagem_comissao;
		close cursor_porcentagem;

		total_comissao := (reg.venda_total * porcentagem_comissao) / 100;

		insert into comissao(comissao_valor, comissao_situacao, data_criacao, data_atualizacao, funcionario_id) 
		values (total_comissao, 'A' , now(), now(), reg.funcionario_id);

		update venda set venda_situacao = 'C' where id = reg.id;

		total_comissao := 0;
		porcentagem_comissao := 0;
	end loop;
end
$$
language plpgsql;

select	calcula_comissao('01/01/2016 00:00:00','01/01/2016 00:00:00');

 
-- Excluindo uma function 
drop function calcula_comissao();