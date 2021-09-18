insert into
   mesa(mesa_codigo, mesa_situacao, data_criacao, data_atualizacao) 
values
   (
      '00001', 'A', '01/01/2016', '01/01/2016'
   )
;
insert into
   mesa(mesa_codigo, mesa_situacao, data_criacao, data_atualizacao) 
values
   (
      '00002', 'A', '01/01/2016', '01/01/2016'
   )
;

insert into
   funcionario(funcionario_codigo, funcionario_nome, funcionario_situacao, funcionario_comissao, funcionario_cargo, data_criacao) 
values
   (
      '0001', 'VINICIUS CARVALHO', 'A', 5, 'GERENTE', '01/01/2016'
   )
;
insert into
   funcionario(funcionario_codigo, funcionario_nome, funcionario_situacao, funcionario_comissao, funcionario_cargo, data_criacao) 
values
   (
      '0002', 'SOUZA', 'A', 2, 'GARÇOM', '01/01/2016'
   )
;
insert into
   produto(produto_codigo, produto_nome, produto_valor, produto_situacao, data_criacao, data_atualizacao) 
values
   (
      '001', 'REFRIGERANTE', 10, 'A', '01/01/2016', '01/01/2016'
   )
;
insert into
   produto(produto_codigo, produto_nome, produto_valor, produto_situacao, data_criacao, data_atualizacao) 
values
   (
      '002', 'AGUA', 3, 'A', '01/01/2016', '01/01/2016'
   )
;
insert into
   produto(produto_codigo, produto_nome, produto_valor, produto_situacao, data_criacao, data_atualizacao) 
values
   (
      '003', 'PASTEL', 7, 'A', '01/01/2016', '01/01/2016'
   )
;
insert into
   venda(venda_codigo, venda_valor, venda_total, venda_desconto, venda_situacao, data_criacao, data_atualizacao, funcionario_id, mesa_id) 
values
   (
      '0001', '20', '20', '0', 'A', '01/01/2016', '01/01/2016', 2, 1 
   )
;
insert into
   venda(venda_codigo, venda_valor, venda_total, venda_desconto, venda_situacao, data_criacao, data_atualizacao, funcionario_id, mesa_id) 
values
   (
      '0002', '21', '21', '0', 'A', '01/01/2016', '01/01/2016', 2, 2
   )
;
insert into
   item_venda(item_valor, item_quantidade, item_total, data_criacao, data_atualizacao, produto_id, venda_id) 
values
   (
      10, 2, 20, '01/01/2016', '01/01/2016', 1, 1
   )
;
insert into
   item_venda(item_valor, item_quantidade, item_total, data_criacao, data_atualizacao, produto_id, venda_id) 
values
   (
      7, 3, 21, '01/01/2016', '01/01/2016', 1, 2
   )
;