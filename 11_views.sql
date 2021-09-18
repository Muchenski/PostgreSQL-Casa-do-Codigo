-- View para buscar os produtos mais vendidos no dia, por ordem alfabética e por ordem de maior venda.

create or replace view 
vendas_do_dia as 
select distinct produto_nome, sum(venda.venda_total) from produto
inner join item_venda
on produto.id = item_venda.produto_id
inner join venda
on item_venda.venda_id = venda.id 
where venda.data_criacao::Date=current_date
group by produto_nome;

select * from vendas_do_dia;
select from vendas_do_dia where produto_nome = 'PASTEL';

/*
 Views são muito utilizadas para limitar o acesso a dados em relação aos usuários do sgbd.
*/