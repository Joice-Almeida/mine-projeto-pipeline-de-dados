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



## Dados que serão utilizados para o projeto



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



## Perguntas

**1 - Por que uma planilha não é ideal para uma empresa que quer analisar suas vendas a fundo?**

**Resposta:**  Uma planilha não é ideal porque não escala para volumes grandes, carece de esquema e validações robustas, é frágil para colaboração simultânea e auditoria, dificulta automação e análises complexas (joins, agregações pesadas) e oferece governança e segurança limitadas, tornando fácil introduzir erros e difícil assegurar qualidade e consistência dos dados.


**2 - Que tipo de perguntas vocês acham que o dono da livraria gostaria de responder com esses dados?**

**Resposta:** O dono da livraria provavelmente quer saber quanto vende por dia/mês/categoria/autor/título e por canal/loja, quais produtos e autores mais vendem, ticket médio e itens por venda, quantos clientes são novos versus recorrentes, qual o LTV e a recência/frequência/valor (RFM), o efeito de promoções e cupons, padrões de sazonalidade e previsões de demanda; se houver dados de estoque, também ruptura e giro.
                                                                             
**3 - Com base nos dados brutos, quais outras duas tabelas precisamos criar? Que colunas e tipos de dados elas teriam?**

**Resposta:**  A partir dos dados brutos, é importante criar duas dimensões: Dim_Clientes (id_cliente STRING; nome STRING; email STRING; telefone STRING; documento STRING; cidade STRING; uf STRING; data_cadastro DATE; ativo BOOL; atualizado_em TIMESTAMP) e Dim_Produtos (id_produto STRING; titulo STRING; autor STRING; categoria STRING; isbn STRING; preco_atual NUMERIC; moeda STRING; ativo BOOL; atualizado_em TIMESTAMP). A tabela de vendas (fato) referenciará essas dimensões via id_cliente e id_produto e deve conter, entre outros, data_venda DATE/TIMESTAMP, quantidade INT64, preco_unitario_no_momento NUMERIC, desconto NUMERIC e valor_total NUMERIC; se precisar de histórico de preços, crie também uma tabela de preços por vigência (id_produto STRING; preco NUMERIC; vigencia_inicio TIMESTAMP; vigencia_fim TIMESTAMP).

**4 - Se o BigQuery não tem chaves estrangeiras, como garantimos que um ID_Cliente na tabela de vendas realmente existe na tabela de clientes?**

**Resposta:** Como o BigQuery não aplica chaves estrangeiras, garantimos a existência do ID por processo: primeiro carregamos/deduplicamos clientes na Dim_Clientes; depois inserimos vendas apenas a partir de um SELECT que faz join/semijoin com Dim_Clientes (e rejeita “órfãos”); usamos MERGE para upsert controlado; executamos testes de qualidade agendados (LEFT JOIN para detectar ids sem correspondência) com alertas; e, se quiser, declaramos constraints NOT ENFORCED para documentação e usamos ferramentas como dbt/Dataform para validar automaticamente.

**5 - Por que é uma boa prática inserir os clientes e produtos em suas próprias tabelas antes de inserir os dados de vendas?**

**Resposta:** Inserir clientes e produtos antes das vendas assegura que as referências existam, permite deduplicação e padronização (evitando variações de nomes/categorias), reduz redundância e custo ao não repetir atributos textuais na fato, melhora performance de consultas por chaves compactas e viabiliza histórico e governança (SCD, auditoria de mudanças).

**6 - Em um cenário com milhões de vendas por dia, o INSERT INTO seria a melhor abordagem?**

**Resposta:** Em cenário de milhões de vendas por dia, não é eficiente fazer muitos INSERT INTO pequenos; prefira cargas em lote a partir do Cloud Storage (Parquet/Avro/ORC), ou streaming de alta taxa via Storage Write API; ingira em tabelas de stage particionadas e depois faça MERGE na fato; particione por data_venda e aplique clustering (por id_produto/id_cliente) para reduzir custo e acelerar consultas.

**7 - Qual é a principal vantagem de usar uma VIEW em vez de simplesmente salvar o código em um arquivo de texto?**

**Resposta:** A principal vantagem de uma VIEW é centralizar e versionar a lógica dentro do próprio warehouse, garantindo que todos usem a mesma definição sempre atualizada sobre os dados base, com controle de acesso (inclusive secure/authorized views), rastreabilidade por catálogo e possibilidade de trocar por uma materialized view quando fizer sentido para performance, ao invés de depender de arquivos de texto dispersos.

**8 - Se o preço de um produto mudar na tabela Produtos, o Valor_Total na VIEW será atualizado automaticamente na próxima vez que a consultarmos?**

**Resposta:**  Sim, uma VIEW é avaliada a cada consulta; se o Valor_Total na VIEW usa o preço atual da tabela Produtos, ele refletirá o novo preço automaticamente. Para manter o histórico correto, armazene na fato o preco_unitario_no_momento (e compute valor_total no evento) ou faça join com uma tabela de preços com vigência usando a data da venda.
