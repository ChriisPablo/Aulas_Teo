
-- listar todas as transações adicionando uma coluna nova 
-- sinalizando "alto", "medio" e "baixo" 
-- para o valor dos pontos 
-- [<10 ; <500; > = 500]

SELECT *,
    CASE
        WHEN qtdePontos < 10 THEN 'baixo'
        WHEN qtdePontos < 500 THEN 'médio'
        ELSE  'alto'
    END AS categoria

FROM transacoes

ORDER BY qtdePontos DESC