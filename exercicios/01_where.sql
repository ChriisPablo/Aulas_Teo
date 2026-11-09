-- lista de transações com apenas 1 ponto;

SELECT IdTransacao, qtdePontos

from transacoes
WHERE qtdePontos = 1