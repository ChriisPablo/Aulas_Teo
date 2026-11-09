-- Quantidade de transações acumuladas ao longo do tempo diário ?

 with tb_diario AS (

    SELECT substr(DtCriacao, 1,10) AS dtDia,
            count(DISTINCT IdTransacao) AS qtdetransacao
    FROM transacoes


    GROUP BY dtDia
    ORDER BY dtDia
),

tb_acum AS (

        SELECT *,
                SUM(qtdetransacao) OVER (ORDER BY dtDia) AS qtdeTransacaoAcum
        FROM tb_diario
)

SELECT * 
FROM tb_acum
WHERE qtdeTransacaoAcum > 100000
ORDER BY  qtdeTransacaoAcum
limit 1 


