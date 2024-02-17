INSERT INTO CREDITO_VOUCHER VALUES(9,32,'2020-02-15','2021-02-15',5,null,1);

select * from CREDITO_VOUCHER WHERE id_wallet = 2 AND (id_compra IS NOT NULL OR data_expiracao >= date(now()));
select * from COMPRAS;
select * from CREDITO_VOUCHER where id_wallet = 3;
select * from CREDITO_BANCO;

-- DANIELE
-- QUESTAO 01
SELECT id_cliente,WALLET.id_wallet,
((valor_compra * -1) + valor_credito + (
	SELECT SUM(valor_voucher)
	FROM CREDITO_VOUCHER 
	WHERE CREDITO_VOUCHER.id_wallet = WALLET.id_wallet 
		AND (id_compra IS NOT NULL 
        OR data_expiracao >= date(now())))) AS saldo_atual
FROM WALLET
JOIN COMPRAS ON WALLET.id_wallet = COMPRAS.id_wallet
JOIN CREDITO_BANCO ON WALLET.id_wallet = CREDITO_BANCO.id_wallet
WHERE
id_cliente = 2;

-- QUESTAO2
SELECT 
    CLIENTE.id_cliente,
    CLIENTE.nome,
    SUM(CASE
        WHEN CREDITO_VOUCHER.id_compra IS NOT NULL THEN CREDITO_VOUCHER.valor_voucher
        ELSE 0
    END) AS total_utilizado,
    SUM(CASE
        WHEN CREDITO_VOUCHER.id_compra IS NULL AND CREDITO_VOUCHER.data_expiracao < CURRENT_DATE()
        THEN CREDITO_VOUCHER.valor_voucher
        ELSE 0
    END) AS total_expirado,
    SUM(CASE
        WHEN CREDITO_VOUCHER.id_compra IS NULL AND CREDITO_VOUCHER.data_expiracao >= CURRENT_DATE()
        THEN CREDITO_VOUCHER.valor_voucher
        ELSE 0
    END) AS total_a_vencer
FROM CREDITO_VOUCHER
JOIN WALLET ON WALLET.id_wallet = CREDITO_VOUCHER.id_wallet
JOIN CLIENTE ON CLIENTE.id_cliente = WALLET.id_cliente
GROUP BY CLIENTE.id_cliente;

-- QUESTAO3
SELECT 
	CREDITO_VOUCHER.id_tipocredito,
    TIPO_CREDITO.tipo_credito,
	ROUND(AVG(DATEDIFF(COMPRAS.data_compra,CREDITO_VOUCHER.data_criacao))) AS media_dias,
	ROUND(AVG(CREDITO_VOUCHER.valor_voucher),2) AS media_valor,
    COUNT(1) AS quantidade
FROM CREDITO_VOUCHER
JOIN COMPRAS ON COMPRAS.id_compra = CREDITO_VOUCHER.id_compra
JOIN TIPO_CREDITO ON TIPO_CREDITO.id_tipocredito = CREDITO_VOUCHER.id_tipocredito
GROUP BY CREDITO_VOUCHER.id_tipocredito;



-- QUESTAO4
SELECT WALLET.id_wallet,CLIENTE.nome,
ROUND(
	SUM(CASE WHEN CREDITO_VOUCHER.id_compra IS NOT NULL THEN CREDITO_VOUCHER.valor_voucher ELSE 0 END) / 
	SUM(CREDITO_VOUCHER.valor_voucher)*100, 0) AS '% utilizado'
FROM WALLET
JOIN CLIENTE ON CLIENTE.id_cliente = WALLET.id_cliente
JOIN CREDITO_VOUCHER ON WALLET.id_wallet = CREDITO_VOUCHER.id_wallet 
WHERE CREDITO_VOUCHER.data_criacao <='2019-12-31'
GROUP BY CREDITO_VOUCHER.id_wallet;

-- MARILIA
-- QUESTAO 1
SELECT 
	DATE_FORMAT(CREDITO_VOUCHER.data_criacao, '%Y-%m') AS data,
    TIPO_CREDITO.tipo_credito,
    SUM(CREDITO_VOUCHER.valor_voucher) AS total_voucher,
    COUNT(1) AS quantidade
FROM CREDITO_VOUCHER
JOIN TIPO_CREDITO ON TIPO_CREDITO.id_tipocredito = CREDITO_VOUCHER.id_tipocredito
GROUP BY TIPO_CREDITO.tipo_credito, DATA
ORDER BY DATA;

-- QUESTAO 2
SELECT WALLET.id_wallet,CLIENTE.nome, SUM(CREDITO_VOUCHER.valor_voucher) AS credito_disponivel
FROM WALLET
JOIN CLIENTE ON CLIENTE.id_cliente = WALLET.id_cliente
JOIN CREDITO_VOUCHER ON WALLET.id_wallet = CREDITO_VOUCHER.id_wallet 
WHERE CREDITO_VOUCHER.id_compra is NULL AND CREDITO_VOUCHER.data_expiracao >= CURRENT_DATE()
GROUP BY CREDITO_VOUCHER.id_wallet;

-- QUESTAO 3
SELECT WALLET.id_wallet,CLIENTE.nome, SUM(CREDITO_VOUCHER.valor_voucher) AS credito_disponivel
FROM WALLET
JOIN CLIENTE ON CLIENTE.id_cliente = WALLET.id_cliente
JOIN CREDITO_VOUCHER ON WALLET.id_wallet = CREDITO_VOUCHER.id_wallet 
WHERE CREDITO_VOUCHER.id_compra is NULL 
AND CREDITO_VOUCHER.data_expiracao BETWEEN '2020-07-01' AND '2020-07-31'
GROUP BY CREDITO_VOUCHER.id_wallet;


-- QUESTAO 4
SELECT 
	DATE(CREDITO_VOUCHER.data_expiracao) AS data_expiracao,
    TIPO_CREDITO.tipo_credito,
    SUM(CREDITO_VOUCHER.valor_voucher) AS total_voucher
FROM CREDITO_VOUCHER
JOIN TIPO_CREDITO ON TIPO_CREDITO.id_tipocredito = CREDITO_VOUCHER.id_tipocredito
WHERE CREDITO_VOUCHER.data_expiracao >= CURRENT_DATE() AND CREDITO_VOUCHER.id_compra IS NULL
GROUP BY TIPO_CREDITO.tipo_credito, CREDITO_VOUCHER.data_expiracao;












