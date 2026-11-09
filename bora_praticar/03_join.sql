-- Qual mês tivemos mais lista de presença ativada?

SELECT 
       substr(t1.DtCriacao,1, 7) AS AnoMes,
       count(DISTINCT t1.IdTransacao) ASQtdetransacao
     
FROM transacoes as t1


LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE DescNomeProduto = 'Lista de presença'

GROUP BY substr(t1.DtCriacao,1, 7)






