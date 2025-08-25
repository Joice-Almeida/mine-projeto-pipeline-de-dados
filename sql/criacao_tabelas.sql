-- Criação da tabela Clientes

CREATE OR REPLACE TABLE t1engenhariadados.turma3_grupo3_3.Clientes (
    id_cliente INT64,
    nome_cliente STRING,
    email_cliente STRING,
    estado_cliente STRING
);

-- Criação da tabela Produtos

CREATE OR REPLACE TABLE `t1engenhariadados.turma3_grupo3_3.Produtos` (
  id_produto INT64,
  nome_produto STRING,
  categoria_produto STRING,
  preco_produto NUMERIC
);

-- Criação da tabela Vendas

CREATE OR REPLACE TABLE `t1engenhariadados.turma3_grupo3_3.Vendas` (
  id_venda INT64,
  id_cliente INT64,
  id_produto INT64,
  data_venda DATE,
  quantidade INT64
);
