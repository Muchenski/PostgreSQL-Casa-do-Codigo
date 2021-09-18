/* Constraint para verificar, a cada novo registro inserido, se o campo venda_total é positivo. */
alter table venda add check(venda_total > 0);

/* Constraint para verificar, a cada novo registro inserido, se o campo nome não é nulo. */
alter table funcionario add check(funcionario_nome <> null);