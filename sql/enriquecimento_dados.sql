WITH base AS (
  SELECT
    V.ID_Venda,
    V.Data_Venda,
    DATE_TRUNC(V.Data_Venda, MONTH) AS Mes,
    EXTRACT(YEAR  FROM V.Data_Venda) AS Ano,
    EXTRACT(MONTH FROM V.Data_Venda) AS Num_Mes,
    C.ID_Cliente, C.Nome_Cliente, C.Email_Cliente, C.Estado_Cliente,
    P.ID_Produto, P.Nome_Produto, P.Categoria_Produto,
    P.Preco_Produto AS Preco_Unitario,
    V.Quantidade,
    CAST(V.Quantidade * P.Preco_Produto AS NUMERIC) AS Valor_Total
  FROM `t1engenhariadados.turma3_grupo3_3.Vendas`   V
  JOIN `t1engenhariadados.turma3_grupo3_3.Clientes` C ON V.ID_Cliente = C.ID_Cliente
  JOIN `t1engenhariadados.turma3_grupo3_3.Produtos` P ON V.ID_Produto = P.ID_Produto
),
w AS (
  SELECT
    b.*,
    -- métricas por cliente
    COUNT(*) OVER (PARTITION BY ID_Cliente) AS Vendas_Cliente,
    SUM(Valor_Total) OVER (
      PARTITION BY ID_Cliente ORDER BY Data_Venda
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Receita_Acumulada_Cliente,
    -- métricas mensais por produto
    SUM(Quantidade) OVER (PARTITION BY Mes, ID_Produto) AS Qtde_Mensal_Produto,
    SUM(Valor_Total) OVER (PARTITION BY Mes) AS Receita_Mensal_Total
  FROM base b
)
SELECT
  *,
  ROUND(Valor_Total / NULLIF(Receita_Mensal_Total,0), 4) AS Part_Receita_Mes,
  DENSE_RANK() OVER (PARTITION BY Mes ORDER BY Qtde_Mensal_Produto DESC) AS Rank_Produto_Mes
FROM w