/* Removendo a tabela 'comissao' para demonstrarmos a adição de constraints após a criação da tabela. */

drop table comissao;

create table comissao(
	id int not null,
	comissao_valor real,
	comissao_situacao varchar(1) default 'A',
	data_criacao timestamp,
	data_atualizacao timestamp,
	funcionario_id int
);

alter table comissao add constraint comissao_pkey primary key(id);

alter table comissao add foreign key(funcionario_id) references funcionario(id);

-- Removendo constraints
alter table comissoes drop constraint comissoes_funcionario_id_fkey;