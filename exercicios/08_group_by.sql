
-- Qual o produto com mais pontos transacionados?

SELECT IdProduto,
        sum(vlProduto * QtdeProduto) AS vlProdutoTransacionado
    
        
FROM transacao_produto
WHERE vlProduto > 0

GROUP BY IdProduto
ORDER BY sum(vlProduto) DESC


