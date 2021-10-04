/* Adicinando novas colunas em tabelas. */
alter table comissao add column data_pagamento int;

/* Dropando uma coluna. */
alter table comissao drop column data_pagamento;


alter table comissao add column data_pagamento int;


/* Alterando o tipo de uma coluna. */
alter table comissao alter column data_pagamento type varchar(30) USING data_pagamento::varchar;
alter table comissao alter column data_pagamento type timestamp USING data_pagamento::timestamp;
