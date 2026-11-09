-- Saldo de pontos acumulado de cada usuário 


WITH tb_clinte_dia AS (

    SELECT idCliente,
        substr(DtCriacao,1,10) AS Dtdia,
        sum(qtdePontos) AS totalpontos,
        sum(CASE WHEN qtdePontos > 0 THEN qtdePontos ELSE 0 END ) as pontosPositivos
    FROM transacoes

    GROUP BY idCliente,Dtdia
)

SELECT *,
        sum(totalpontos) OVER (PARTITION BY idCliente ORDER BY Dtdia) AS SaldoPontos,
        sum(pontosPositivos) OVER (PARTITION BY idCliente ORDER BY Dtdia) AS totalPontosPositivos
FROM tb_clinte_dia
