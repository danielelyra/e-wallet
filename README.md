# E-WALLET: APLICAÇÃO DE MODELO RELACIONAL PARA TRANSAÇÕES FINANCEIRAS

Estudo de caso realizado no curso de MBA Business Analytics e Big Data na Fundação Getúlio Vargas (FGV). 

Carteira digital ou e-wallet é uma aplicação que permite fazer os pagamentos com o telemóvel ou computador. 

Uso de um banco de dados relacional para o armazenamento dos dados financeiros, de forma a garantir a segurança e o controle das transações eletrônicas.

O objetivo do estudo foi identificar uma situação problema (real ou hipotética), a fim de propor uma solução de armazenamento, modelagem dos dados financeiros, regras de negócio para operação e a análise de dados para a tomada de decisão. 

Para a modelagem e implementação usei o Workbench e a base de dados utilizada foi o MySQL. 

Utilizei Python para gerar a massa de dados de forma aleatória e concisa, obtendo assim uma base mais robusta. 

Como isso, temos um conjunto de dados enriquecido para as análises realizadas com SQL, assim como por visualização utilizando o Tableau. 

## Implementação do Modelo Relacional

No arquivo "Modelagem_Wallet.mwb", temos as estruturas dos dados e as tabelas criadas no modelo e podem ser visualizados com o MySQL Workbench.

## Estrutura das Tabelas do Modelo 

**Cliente:** campo identificador exclusivo seguido por dados cadastrais (nome, endereço, etc).
**Wallet:** campo identificador exclusivo e data de criação da carteira digital.
**Compras:** campo identificador exclusivo, data e valor da transação de compra.
**Tipo Crédito:** campo identificador exclusivo, prazo de validade e o tipo de crédito.
**Crédito Banco:** campo identificador exclusivo, valor do crédito, data de criação e liberação do crédito e código do banco.
**Crédito Voucher:** campo identificador exclusivo, valor do crédito e data de criação e expiração do voucher.

## Operações no Banco de Dados com SQL
No arquivo "Query_Consultas.sql", possui as consultas geradas em SQL com o intuito de analisar o passivo da carteira digital na empresa. 
Tais como: 
  1) O saldo diário por cliente.
  2) Valores dos créditos utilizados, expirados e a vencer.
  3) Valor e prazo médio da utilização dos créditos do tipo.
  4) O percentual de crédito utilizados durante o ano de 2019.

## Análise Visual usando o Tableau
O arquivo "Wallet_dados.xlsx" é a base de dados das transações na carteira digital gerada para importação no Tableau.

Em "E-Wallet.pdf" faço uma demonstração das seguintes análises feitas usando a ferramenta, são elas:
  1) Volume (R$) das compras por ano.
  2) Clientes por região que efetuaram compras utilizando o crédito voucher no ano de 2019.
  3) Volume de crédito voucher (R$) criados e utilizados em compras no ano de 2019.
  4)  Volume de crédito voucher (R$) expirados em 2019 e que não foram utilizados.
