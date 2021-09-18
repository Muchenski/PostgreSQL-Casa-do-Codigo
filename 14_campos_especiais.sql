-- Tipos de campos especiais.

-- #####################################################################################################################

-- Array.

alter table produto add column produto_categoria text[];

insert into produto(
	produto_codigo, 
	produto_nome, 
	produto_valor, 
	produto_situacao, 
	data_criacao, 
	data_atualizacao, 
	produto_categoria
) 
values(
	'03251', 
	'ESFIRRA', 
	5, 
	'A', 
	'01/01/2016', 
	'01/01/2016', 
	'{"CARNE", "SALGADO", "ASSADO" , "QUEIJO"}'
);

select produto_categoria from produto where produto_nome like 'ESFIRRA'; -- [OUT]: {CARNE,SALGADO,ASSADO,QUEIJO}

-- Obtendo valor de índice específico do array.
select produto_categoria[2] from produto where produto_nome like 'ESFIRRA'; -- [OUT]: "SALGADO"

-- Obtendo valores de um intervalo do array.
select produto_categoria[2:4] from produto where produto_nome like 'ESFIRRA'; -- [OUT]: "{SALGADO,ASSADO,QUEIJO}"

-- #####################################################################################################################

-- JSON.

alter table produto add column produto_estoque json;

insert into produto(
	produto_codigo, 
	produto_nome, 
	produto_valor, 
	produto_situacao, 
	data_criacao, 
	data_atualizacao, 
	produto_categoria, 
	produto_estoque
) 
values
(
	'6234', 
	'COCA-COLA', 
	6, 
	'A', 
	'01/01/2016', 
	'01/01/2016', 
	'{"REFRIGERANTE", "LATA", "BEBIDA", "COLA"}', 
	'{
		"info_estoque": {
			"tem_estoque": "SIM", 
			"quantidade": 17, 
			"ultima_compra":"01/01/16"
		} 
	}' 
);


/*
[OUT]:
{
	"info_estoque": {
		"tem_estoque": "SIM", 
		"quantidade": 17, 
		"ultima_compra":"01/01/16"
	} 
}
*/
select produto_estoque from produto where produto_nome like 'COCA-COLA';

-- Obtendo apenas o atributo desejado do objeto.
-- O operador '->>' retorna o valor em forma de texto.
-- [OUT]: 17
select produto_estoque->'info_estoque'->>'quantidade' as quantidade from produto where produto_nome like 'COCA-COLA';

-- Obtendo apenas o atributo desejado do objeto.
-- O operador '->' retorna o valor da forma que foi inserido no banco de dados(repare nas àspas duplas do valor do atributo JSON).
-- [OUT]: "01/01/16"
select produto_estoque->'info_estoque'->'ultima_compra' as ultima_compra from produto where produto_nome like 'COCA-COLA';

-- #####################################################################################################################

-- Cenário mais complexo:

insert into produto(
	produto_codigo, 
	produto_nome, 
	produto_valor, 
	produto_situacao, 
	data_criacao, 
	data_atualizacao, 
	produto_categoria, 
	produto_estoque
) 
values
(
	'77978', 
 	'GATORADE', 
	6, 
	'A', 
	'01/01/2016', 
	'01/01/2016', 
	'{"ISOTONICO", "GARRAFA", "BEBIDA" }', 
	'{ 
		"info_estoque": { 
			"tem_estoque": "SIM", 
			"quantidade": 17, 
			"ultima_compra": "01/01/16" 
			}, 
		"ultima_venda": "02/01/2016" 
	}' 
);

-- Utilizando valores do JSON como critério no where.
select produto_estoque from produto where produto_estoque->>'ultima_venda' = '02/01/2016';
/*
[OUT]:
{ 
	"info_estoque": { 
		"tem_estoque": "SIM", 
		"quantidade": 17, 
		"ultima_compra": "01/01/16" 
	}, 
	"ultima_venda": "02/01/2016" 
}
*/