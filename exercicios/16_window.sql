-- Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?

with Tb_dia_cliente AS (

    SELECT substr(DtCriacao,1,10) AS dtDia,
        count(DISTINCT idCliente) AS qtdeCliente
    FROM clientes

    GROUP BY dtDia
),

tb_acum AS (
    SELECT *,
            sum(qtdeCliente) OVER (ORDER BY dtDia) AS qtdeClienteAcum
    FROM tb_dia_cliente
)

SELECT *
FROM tb_acum
ORDER BY DTdIA