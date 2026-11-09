
-- Dos clientes que começaram SQL no primeiro dia, quantos chegaram ao
-- 5° dia?

SELECT count( DISTINCT idCliente) 
FROM transacoes AS t1
WHERE t1.idCliente IN (

    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
)
and 
 substr(t1.DtCriacao, 1, 10) = '2025-08-29'

 

