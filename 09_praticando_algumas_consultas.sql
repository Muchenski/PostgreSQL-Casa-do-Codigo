-- http://pgdocptbr.sourceforge.net/pg80/functions-aggregate.html

create or replace 
function retorna_nome_produto(prod_id int) 
returns text as 
$$ 
declare 
	nome text; 
begin 
	select produto_nome 
	into nome 
	from produto 
	where id = prod_id; 
	return nome; 
end 
$$ 
language plpgsql;

-- Consultando os produtos que estão relacionados a vendas e realizando contagem.
select retorna_nome_produto(produto_id), count(id) QTDE from item_venda 
group by produto_id;

-- Consultando os produtos que estão relacionados a vendas, desde que existam mais do que 2 produtos em vendas.
select retorna_nome_produto(produto_id) produto, count(id) qtde from item_venda 
group by produto_id
having count(produto_id) >= 3 
order by qtde;