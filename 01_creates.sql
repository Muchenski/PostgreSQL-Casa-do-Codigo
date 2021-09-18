/* Criação inicial do banco de dados do projeto. */

create table mesa(
	id int not null primary key,
	mesa_codigo varchar(20),
	mesa_situacao varchar(1) default 'A',
	data_criacao timestamp,
	data_atualizacao timestamp
);

create table funcionario(
	id int not null primary key,
	funcionario_codigo varchar(20),
	funcionario_nome varchar(100),
	funcionario_situacao varchar(1) default 'A',
	funcionario_comissao real,
	funcionario_cargo varchar(30),
	data_criacao timestamp,
	data_atualizacao timestamp
);

create table venda(
	id int not null primary key,
	venda_codigo varchar(20),
	venda_valor real,
	venda_total real,
	venda_desconto real,
	venda_situacao varchar(1) default 'A',
	data_criacao timestamp,
	data_atualizacao timestamp,
	funcionario_id int references funcionario(id),
	mesa_id int references mesa(id)
);

create table produto(
	id int not null primary key,
	produto_codigo varchar(20),
	produto_nome varchar(60),
	produto_valor real,
	produto_situacao varchar(1) default 'A',
	data_criacao timestamp,
	data_atualizacao timestamp
);

create table item_venda(
	id int not null primary key,
	item_valor real,
	item_quantidade int,
	item_total real,
	data_criacao timestamp,
	data_atualizacao timestamp,
	produto_id int references produto(id),
	venda_id int references venda(id)
);

create table comissao(
	id int not null primary key,
	comissao_valor real,
	comissao_situacao varchar(1) default 'A',
	data_criacao timestamp,
	data_atualizacao timestamp,
	funcionario_id int references funcionario(id)
);