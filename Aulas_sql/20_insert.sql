
DELETE FROM relatorio_diario;

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

INSERT INTO relatorio_diario

SELECT * 
FROM  tb_acum;

SELECT *
FROM  relatorio_diario;
