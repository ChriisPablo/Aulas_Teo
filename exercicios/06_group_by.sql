
-- Qual dia da semana quem mais pedidos em 2025?

SELECT
        strftime('%w',substr(DtCriacao,1,10)) AS DiaSemana,
        count(DISTINCT IdTransacao) AS qtdeTransacao
FROM transacoes

WHERE substr(DtCriacao, 1,4) = '2025'

GROUP BY strftime('%w',substr(DtCriacao,1,10)) -- ou  1

ORDER BY 2 DESC
