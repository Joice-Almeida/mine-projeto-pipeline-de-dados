# mini-projeto-pipeline-de-dados
Esse projeto tem como objetivo praticar os conceitos de pipeline e análise de dados com SQL utilizando BigQuery

## Contexto e cenário utilizado para atividade proposta para esse projeto

“Olá, pessoal! Hoje, vamos deixar de ser apenas estudantes de SQL para nos tornarmos analistas de dados em uma missão real. Nossa cliente é a ‘Livraria DevSaber’, uma nova loja online que fez suas primeiras vendas e, até agora, anotou tudo em uma planilha. Isso é um começo, mas para crescer, eles precisam de insights. Nossa missão é transformar essa planilha em um mini data warehouse inteligente no Google BigQuery. Vamos construir todo o pipeline de dados: desde criar a estrutura, carregar os dados, até extrair as respostas que ajudarão a livraria a entender seus negócios.”

**Missão do Projeto**

Você deve criar um conjunto de scripts SQL para:

1. **Definir o Schema**: Criar as tabelas `Clientes`, `Produtos` e `Vendas`.
2. **Ingerir os Dados**: Inserir os dados brutos fornecidos nas tabelas.
3. **Analisar os Dados**: Escrever consultas SQL para responder a perguntas de negócio.
4. **Criar uma View**: Construir uma `VIEW` para simplificar análises futuras.


##Dados que serão utilizados para o projeto


| id_venda | nome_cliente  | email_cliente       | estado_cliente | nome_produto           | categoria_produto   | preco_produto | data_venda  | quantidade |
|----------|---------------|---------------------|----------------|------------------------|---------------------|---------------|-------------|------------|
| 1        | Ana Silva     | ana.s@email.com     | SP             | Fundamentos de SQL     | Dados               | 60.00         | 2022-01-15  | 1          |
| 2        | Bruno Costa   | b.costa@email.com   | RJ             | Duna                   | Ficção Científica   | 80.00         | 2022-01-18  | 1          |
| 3        | Carla Dias    | c.dias@email.com    | SP             | Python para Dados      | Programação         | 75.00         | 2022-01-20  | 2          |
| 4        | Ana Silva     | ana.s@email.com     | SP             | Duna                   | Ficção Científica   | 80.00         | 2022-01-25  | 1          |
| 5        | Daniel Souza  | d.souza@email.com   | MG             | Fundamentos de SQL     | Dados               | 60.00         | 2022-01-28  | 1          |
| 6        | Bruno Costa   | b.costa@email.com   | RJ             | O Guia do Mochileiro   | Ficção Científica   | 50.00         | 2022-01-30  | 1          |


## Informações de acesso ao dataset e os scripts

Os scripts estão localizados na pasta [Acesse a pasta de scripts SQL](./sql/)
No BigQuery em um projeto chamado t1engenhariadados foi criado um dataset chamado turma3_grupo3_3, onde foram criadas as tabelas:
- Clientes
- Produtos
- Vendas

**Descrição dos campos da tabela Clientes**

- id_cliente (identificador do cliente - Primary key)
- nome_cliente (nome do cliente)
- email_cliente (e-mail do cliente)
- estado_cliente ( estado onde o cliente reside)

 **Descrição dos campos da tabela Produtos**
 
 - id_produto (identificador do produto - Primary key)
 - nome_produto (nome do produto a ser vendido )
 - categoria_produto ( categoria que determinado produto se enquadra)
 - preco_produto ( preço de determinado produto)

 **Descrição dos campos da tabela Vendas**
 
 - id_venda (identificador da compra - Primary key)
 - id_cliente ( identificador do cliente - Foreign key)
 - id_produto (identificador do produto - Foreign key)
 - data_venda ( registra a data da venda)
 - quantidade ( registra a quantidade vendida)
   

## Perguntas

**1 - Por que uma planilha não é ideal para uma empresa que quer analisar suas vendas a fundo?**




**2 - Que tipo de perguntas vocês acham que o dono da livraria gostaria de responder com esses dados?**




                                                                                                
**3 - Com base nos dados brutos, quais outras duas tabelas precisamos criar? Que colunas e tipos de dados elas teriam?**


**4 - Se o BigQuery não tem chaves estrangeiras, como garantimos que um ID_Cliente na tabela de vendas realmente existe na tabela de clientes?**


**5 - Por que é uma boa prática inserir os clientes e produtos em suas próprias tabelas antes de inserir os dados de vendas?**


**6 - Em um cenário com milhões de vendas por dia, o INSERT INTO seria a melhor abordagem?**

**7 - Qual é a principal vantagem de usar uma VIEW em vez de simplesmente salvar o código em um arquivo de texto?**

**8 - Se o preço de um produto mudar na tabela Produtos, o Valor_Total na VIEW será atualizado automaticamente na próxima vez que a consultarmos?**

