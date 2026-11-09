-- vAMOS CONTRUIR UMA TABELA COM O PERFIL COMPORTAMENTAL 
-- DOS NOSSOS USUÁRIOS 

WITH tb_transacoes AS (

    SELECT IdTransacao,
       Idcliente,
       qtdePontos,
       Datetime(substr(DtCriacao,1,19)) AS DtCriacao,
       JULIANDAY('now') - JULIANDAY(SUBSTR(DtCriacao,1,10)) AS diffDate
    FROM transacoes 
    
),

tb_cliente AS (

SELECT Idcliente,
       Datetime(substr(DtCriacao,1,19)) AS DtCriacao,
       JULIANDAY('now') - JULIANDAY(SUBSTR(DtCriacao,1,10)) AS IdadeBase
FROM clientes
),

tb_sumario_transacoes AS (

    SELECT idCliente,

            count(Idtransacao) AS QtdeTransacoesVida,
            count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS QtdeTransacoes56,
            count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS QtdeTransacoes28,
            count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS QtdeTransacoes14,
            count(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS QtdeTransacoes7,
            
            sum(qtdePontos) AS SaldoPontos,

            min(diffDate) AS DiasUltimaInteracao,

            sum(CASE WHEN qtdePontos > 0 THEN qtdePontos ELSE 0 END) AS QtdePontosPosVida,
            sum(CASE WHEN qtdePontos > 0 AND diffDate <= 56 THEN qtdePontos END) AS qtdePontosPosis56,
            sum(CASE WHEN qtdePontos > 0 AND diffDate <= 28 THEN qtdePontos END) AS qtdePontosPosis28,
            sum(CASE WHEN qtdePontos > 0 AND diffDate <= 14 THEN qtdePontos END) AS qtdePontosPosis14,
            sum(CASE WHEN qtdePontos > 0 AND diffDate <= 7 THEN qtdePontos END) AS qtdePontosPosis7,


            sum(CASE WHEN qtdePontos < 0 THEN qtdePontos ELSE 0 END) AS QtdePontosNegVida,
            sum(CASE WHEN qtdePontos < 0 AND diffDate <= 56 THEN qtdePontos END) AS qtdePontosNegis56,
            sum(CASE WHEN qtdePontos < 0 AND diffDate <= 28 THEN qtdePontos END) AS qtdePontosNegis28,
            sum(CASE WHEN qtdePontos < 0 AND diffDate <= 14 THEN qtdePontos END) AS qtdePontosNegis14,
            sum(CASE WHEN qtdePontos < 0 AND diffDate <= 7 THEN qtdePontos END) AS qtdePontosNegis7

    FROM tb_transacoes
    GROUP BY Idcliente
),



tb_trasacao_produto AS (

    SELECT t1.*,
        t3.DescNomeProduto,
        t3.DescCategoriaProduto

    FROM tb_transacoes AS t1

    LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao

    LEFT JOIN produtos as t3
    on t2.IdProduto = t3.IdProduto
),

tb_cliente_produto AS (

    SELECT Idcliente,
            DescNomeProduto,
            count(*) AS qtdeVida,
            count(CASE WHEN diffDate <= 56 then idtransacao END) AS Qtd56,
            count(CASE WHEN diffDate <= 28 then idtransacao END) AS Qtd28,
            count(CASE WHEN diffDate <= 14 then idtransacao END) AS Qtd14,
            count(CASE WHEN diffDate <= 7 then idtransacao END) AS Qtd7 

    FROM tb_trasacao_produto
    GROUP BY Idcliente, DescNomeProduto
),

tb_cliente_produto_rn AS (

    SELECT *,
            ROW_number() over (PARTITION BY Idcliente ORDER BY qtd56 DESC) AS rnVida,
            ROW_number() over (PARTITION BY Idcliente ORDER BY qtd56 DESC) AS rn56,
            ROW_number() over (PARTITION BY Idcliente ORDER BY qtd28 DESC) AS rn28,
            ROW_number() over (PARTITION BY Idcliente ORDER BY qtd14 DESC) AS rn14,
            ROW_number() over (PARTITION BY Idcliente ORDER BY qtd7 DESC) AS rn7

    FROM tb_cliente_produto
),


Tb_join AS (

    SELECT t1.*,
        t2.IdadeBase,
        t3.DescNomeProduto AS produtoVida,
        t4.DescNomeProduto AS produto56,
        t5.DescNomeProduto AS produto28,
        t6.DescNomeProduto AS produto14,
        t7.DescNomeProduto AS produto7

    FROM tb_sumario_transacoes AS t1
    LEFT JOIN tb_cliente AS t2
    ON t1.Idcliente = t2.idCliente

    LEFT JOIN tb_cliente_produto_rn as t3
    ON t1.idCliente = t3.idCliente
    AND t3.rnVida = 1

    LEFT JOIN tb_cliente_produto_rn as t4
    ON t1.idCliente = t4.idCliente
    AND t4.rn56 = 1

    LEFT JOIN tb_cliente_produto_rn as t5
    ON t1.idCliente = t5.idCliente
    AND t5.rn28 = 1

    LEFT JOIN tb_cliente_produto_rn as t6
    ON t1.idCliente = t6.idCliente
    AND t6.rn14 = 1

    LEFT JOIN tb_cliente_produto_rn as t7
    ON t1.idCliente = t7.idCliente
    AND t7.rn7 = 1
)


SELECT * FROM Tb_join
ORDER BY Idcliente