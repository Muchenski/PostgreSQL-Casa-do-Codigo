/* Criando sequências numéricas únicas para incrementar os id's das tabelas. */

create sequence	mesa_id_seq start with 1 increment by 1;
create sequence	venda_id_seq start with 1 increment by 1;
create sequence	item_venda_id_seq start with 1 increment by 1;
create sequence	produto_id_seq start with 1 increment by 1;
create sequence	funcionario_id_seq start with 1 increment by 1;
create sequence	comissao_id_seq start with 1 increment by 1;

/* Associando as sequências às tabelas. */

alter table mesa alter column id set default nextval('mesa_id_seq'::regclass);
alter table venda alter column id set default nextval('venda_id_seq'::regclass);
alter table item_venda alter column id set default nextval('item_venda_id_seq'::regclass);
alter table produto alter column id set default nextval('produto_id_seq'::regclass);
alter table funcionario alter column id set default nextval('funcionario_id_seq'::regclass);
alter table comissao alter column id set default nextval('comissao_id_seq'::regclass);

/*
 A vantagem da utilização das sequences é que, caso não quisermos mais usá-las, apenas deletamos	
 a sequence e utilizamos outro meio para inserir a sequência da chave primária.
*/

-- Deletando uma sequência:
drop sequence funcionario_id_seq cascade;

/*
 Devemos utilizar o 'cascade' para excluir também o vínculo da sequência com tabela.
 Caso não esteja sendo vinculada a tabela qualquer, não há motivo para utilizar o comando 'cascade'.
*/