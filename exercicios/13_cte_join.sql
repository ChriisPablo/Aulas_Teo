
-- Dentre os clientes de janeiro/2025, quantos assitiram o curso de SQL?


WITH Tb_clientes_jan AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE DtCriacao >= '2025-01-01'
    AND DtCriacao <'2025-02-01'
),

tb_cliente_curso AS (
SELECT DISTINCT idCliente
FROM transacoes
WHERE DtCriacao >='2025-08-25'
AND DtCriacao < '2025-08-30'
)

SELECT count(t1.idCliente) AS ClienteJaneiro,
       count(t2.idCliente) As ClienteCurso
FROM Tb_clientes_jan AS t1

LEFT JOIN tb_cliente_curso AS t2
ON t1.idCliente = t2.idCliente
