 --pedidos realizados no fim de semana 

 SELECT IdTransacao, 
        DtCriacao,
        substr(DtCriacao, 1, 19) AS DtCriacaoNova,
        datetime(substr(DtCriacao, 1, 19)) AS DataNova, 
        strftime('%w', datetime(substr(DtCriacao,1,19))) AS DiaSemana
        
       
 from transacoes

    WHERE strftime('%w', datetime(substr(DtCriacao,1,19))) IN ('6','0')
