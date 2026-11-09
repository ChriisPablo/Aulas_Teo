-- Qual o dia da semana mais ativo de cada usuário?


WITH tb_cliente_semana AS (
SELECT idCliente,
        strftime('%w',substr(DtCriacao,1,10)) AS DtdiaSemana,
         count(DISTINCT IdTransacao) AS Qtdetransacao

FROM transacoes
GROUP BY idCliente, DtdiaSemana
),

tb_rn AS (

    SELECT *,
       CASE
        WHEN DtdiaSemana = '1' THEN 'SEGUNDA FEIRA' 
        WHEN DtdiaSemana = '2' THEN 'TERÇA FEIRA' 
        WHEN DtdiaSemana = '3' THEN 'QUARTA FEIRA' 
        WHEN DtdiaSemana = '4' THEN 'QUINTA FEIRA' 
        WHEN DtdiaSemana = '5' THEN 'SEXTA FEIRA' 
        WHEN DtdiaSemana = '6' THEN 'SABADO' 
        ELSE 'DOMINGO'
        END AS descdiaSemana,

        ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY Qtdetransacao DESC) AS RN

    FROM tb_cliente_semana
)

SELECT * 
FROM tb_rn
WHERE rn = 1