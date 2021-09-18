/* Criando uma tabela de logs, uma função e um trigger que executará esta função a partir de eventos.*/

/*
 Se utilizarmos o comando truncate para excluir os registros de uma tabela, 
 ele não vai disparar as triggers que estiverem configuradas 
 para disparar on delete, pois o truncate ignora qualquer trigger.
*/

create table log_produto(
	id int not null primary key,
	data_alteracao timestamp,
	alteracao_tipo varchar(10),
	id_old int, 
	produto_codigo_old varchar(20), 
	produto_nome_old varchar(60), 
	produto_valor_old real, 
	produto_situacao_old varchar(1) default 'A', 
	data_criacao_old timestamp, 
	data_atualizacao_old timestamp, 
	id_new int, 
	produto_codigo_new varchar(20), 
	produto_nome_new varchar(60), 
	produto_valor_new real, 
	produto_situacao_new varchar(1) default 'A', 
	data_criacao_new timestamp, 
	data_atualizacao_new timestamp
);

create sequence log_produto_id_seq start with 1 increment by 1;
alter table log_produto alter column id set default nextval('log_produto_id_seq'::regclass);

create or replace
function gera_log_produto()
returns trigger as
$$
begin
	if TG_OP = 'INSERT' then
		insert into log_produto(
			alteracao_tipo,
			data_alteracao,
			id_new,
			produto_codigo_new,
			produto_nome_new,
			produto_valor_new,
			produto_situacao_new,
			data_criacao_new,
			data_atualizacao_new
		)
		values(
			TG_OP,
			now(),
			new.id,
			new.produto_codigo,
			new.produto_nome,
			new.produto_valor,
			new.produto_situacao,
			new.data_criacao,
			new.data_atualizacao
		);
		return new;
		
	elsif TG_OP = 'UPDATE' then
		insert into log_produto(
			alteracao_tipo,
			data_alteracao,
			id_old,
			produto_codigo_old,
			produto_nome_old,
			produto_valor_old,
			produto_situacao_old,
			data_criacao_old,
			data_atualizacao_old,
			id_new,
			produto_codigo_new,
			produto_nome_new,
			produto_valor_new,
			produto_situacao_new,
			data_criacao_new,
			data_atualizacao_new
		)
		values(
			TG_OP,
			now(),
			old.id,
			old.produto_codigo,
			old.produto_nome,
			old.produto_valor,
			old.produto_situacao,
			old.data_criacao,
			old.data_atualizacao,
			new.id,
			new.produto_codigo,
			new.produto_nome,
			new.produto_valor,
			new.produto_situacao,
			new.data_criacao,
			new.data_atualizacao
		);
		return new;
		
	elsif TG_OP = 'DELETE' then
		insert into log_produto(
			alteracao_tipo,
			data_alteracao,
			id_old,
			produto_codigo_old,
			produto_nome_old,
			produto_valor_old,
			produto_situacao_old,
			data_criacao_old,
			data_atualizacao_old
		)
		values(
			TG_OP,
			now(),
			old.id,
			old.produto_codigo,
			old.produto_nome,
			old.produto_valor,
			old.produto_situacao,
			old.data_criacao,
			old.data_atualizacao
		);
		return new;
	end	if;
end;
$$
language plpgsql;

create trigger tri_log_produto after insert or update or delete on produto for each row execute procedure gera_log_produto();

-- Desabilitando a trigger 'tri_log_produtos' nos eventos relacionados a tabela 'produto':
alter table produto disable trigger tri_log_produto;

-- Habilitando novamente a trigger:
alter table produto enable trigger tri_log_produto;

-- Excluindo uma trigger:
drop trigger tri_log_produto on produto;


/* Testando a trigger e a função: */

insert into produto(produto_codigo, produto_nome, produto_valor, produto_situacao, data_criacao, data_atualizacao) 
values('1512', 'LAZANHA', 46, 'A', '01/01/2016', '01/01/2016');

insert into produto(produto_codigo, produto_nome, produto_valor, produto_situacao, data_criacao, data_atualizacao) 
values('1613', 'PANQUECA', 38, 'A', '01/01/2016', '01/01/2016');

insert into produto(produto_codigo, produto_nome, produto_valor, produto_situacao, data_criacao, data_atualizacao)
values('733', 'CHURRASCO', 72, 'A', '01/01/2016', '01/01/2016');

select alteracao_tipo, data_alteracao, id_new, produto_codigo_new, produto_nome_new, produto_valor_new, produto_situacao_new, data_criacao_new, data_atualizacao_new from log_produto;

update produto set produto_valor = 99 where produto_nome = 'CHURRASCO';

select * from log_produto;

delete from produto where produto_nome = 'PANQUECA';

select * from log_produto;
