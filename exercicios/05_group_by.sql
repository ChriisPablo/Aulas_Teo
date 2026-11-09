--Qual o valor médio de pontos positivos por dia?

SELECT sum(qtdePontos) AS totalPontos,
    count(DISTINCT substr(DtCriacao,1,10)) AS qtdeDiasRepetidos,
    sum(qtdePontos) / count(DISTINCT substr(DtCriacao,1,10)) AS avgPontosDia
        
FROM transacoes

WHERE qtdePontos > 0


