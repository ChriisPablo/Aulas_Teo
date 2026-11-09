
SELECT  round(avg(qtdePontos),2) AS mediaCarteira,
    1. * sum(qtdePontos) / count(idCliente) AS mediaCarteiraRoots,
        min(qtdePontos) as MinCarteira,
        max(qtdePontos) AS MaxCarteira,
        sum(flTwitch),
        sum(flEmail)
FROm clientes
