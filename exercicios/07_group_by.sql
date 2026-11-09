
--  qual é o produto mais transacionado?

SELECT IdProduto,
        count(*),
        sum(QtdeProduto) AS QtdeProdutoSum
FROM transacao_produto

GROUP BY IdProduto
ORDER BY count(*) DESC

limit 1 
