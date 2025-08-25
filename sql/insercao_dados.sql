-- Inserindo dados na tabela Clientes

INSERT INTO `t1engenhariadados.turma3_grupo3_3.Clientes` (id_cliente,nome_cliente,email_cliente,estado_cliente)
VALUES 
      (1,"Ana Silva","ana.s@email","SP"),
      (2,"Bruno Costa","b.costa@email.com","RJ"),
      (3,"Carla Dias","carla.d@email.com","SP"),
      (4,"Ana Silva","ana.s@email.com","SP");

INSERT INTO `t1engenhariadados.turma3_grupo3_3.Clientes` (id_cliente,nome_cliente,email_cliente,estado_cliente)
VALUES
      (5,"Daniel Souza","daniel.s@email.com","MG"),
      (6,"Bruno Costa","b.costa@email.com","RJ");


-- Inserindo dados na tabela Produtos

INSERT INTO `t1engenhariadados.turma3_grupo3_3.Produtos` (id_produto,nome_produto,categoria_produto,preco_produto)
VALUES
      (101,"Fundamentos de SQL","Dados",60.00),
      (102,"Duna","Ficção Científica",80.50),
      (103,"Python para Dados","Programação",75.00),
      (102,"Duna","Ficção Científica",80.50),
      (101,"Fundamentos de SQL","Dados",60.00),
      (104,"O Guia do Mochileiro","Ficção Científica",42.00);


-- Inserindo dados na tabela Vendas

INSERT INTO `t1engenhariadados.turma3_grupo3_3.Vendas` (id_venda,id_cliente,id_produto,data_venda,quantidade)
VALUES
      (1,1,101,"2024-01-15",1),
      (2,2,102,"2024-01-18",1),
      (3,3,103,"2024-02-02",2),
      (4,4,102,"2024-02-10",1),
      (5,5,101,"2024-02-20",1),
      (6,6,104,"2024-03-05",1);
