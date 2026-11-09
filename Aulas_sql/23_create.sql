DROP TABLE if EXISTS clientes_d28;

CREATE TABLE IF NOT EXISTS  clientes_d28 (
    Idcliente varchar(250) PRIMARY KEY,
    Qtdetrasacoes INTEGER
);

DELETE FROM clientes_d28;

INSERT INTO clientes_d28
SELECT idCliente,
        count(DISTINCT IdTransacao) AS Qtdetrasacoes

FROM transacoes
WHERE julianday('now') - julianday(substr(DtCriacao,1,10)) <= '28'
GROUP BY Idcliente
;

SELECT * FROM clientes_d28;
