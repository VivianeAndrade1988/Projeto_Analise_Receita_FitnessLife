===============================================================================
/*
PROJETO: FitLife Data Warehouse
ETAPA: Carga Inicial de Dados (Manual Load)
DESCRIÇÃO: Script para execução manual da primeira carga de dados para a Bronze.
    1. Limpeza (TRUNCATE/DROP) das tabelas bronze existentes.
    2. Ingestão via INSERT INTO / SELECT para validar conectividade.
    3. Verificação de volumetria.
*/
===============================================================================
-- 

CREATE PROCEDURE CARGA_BRONZE_ATIVIDADE -- QUANDO ALGUEM APAGAR ALGUMA TABELA, ELE GERA TUDO DENOVO.
AS


---------------------------------------------------------------
--- VERIFICA SE O SCHEMA EXISTE, SE NÃO EXISTIR ELE CRIA
----------------------------------------------------------------

if object_id ('bronze_atividade') is not null
DROP TABLE bronze_atividade

CREATE TABLE bronze_atividade (
    id_atividade INT PRIMARY KEY,
    tipo_atividade VARCHAR(50)
);


---------------------------------------------------------------
---LIMPA ÁREA
----------------------------------------------------------------

TRUNCATE TABLE BRONZE_ATIVIDADE

---------------------------------------------------------------
--- POPULANDO AREA
----------------------------------------------------------------

INSERT INTO BRONZE_ATIVIDADE
SELECT *FROM FITNESSLIFE.DBO.ATIVIDADE




--=====================================
--   CARGA_BRONZE_CLIENTE
--=====================================


CREATE PROCEDURE CARGA_BRONZE_CLIENTE -- QUANDO ALGUEM APAGAR ALGUMA TABELA, ELE GERA TUDO DENOVO.
AS

---------------------------------------------------------------
--- VERIFICA SE O SCHEMA EXISTE, SE NÃO EXISTIR ELE CRIA
----------------------------------------------------------------

if object_id ('bronze_cliente') is not null
DROP TABLE bronze_cliente

CREATE TABLE bronze_cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,  
    nome_cliente VARCHAR(100),
    idade INT,
    cidade VARCHAR(50),
    data_cadastro DATE,
    id_plano INT,
    id_atividade INT,
    data_cancelamento DATE
);

---------------------------------------------------------------
---LIMPA ÁREA
----------------------------------------------------------------

TRUNCATE TABLE BRONZE_CLIENTE

---------------------------------------------------------------
--- POPULANDO AREA
----------------------------------------------------------------

-- 2. Permite inserir o ID que vem da base original
SET IDENTITY_INSERT BRONZE_CLIENTE ON;

-- 3. Insere os dados listando as colunas (obrigatório quando tem Identity)
INSERT INTO BRONZE_CLIENTE (
    id_cliente, 
    nome_cliente, 
    idade, 
    cidade, 
    data_cadastro, 
    id_plano, 
    id_atividade, 
    data_cancelamento
)
SELECT 
    id_cliente, 
    nome_cliente, 
    idade, 
    cidade, 
    data_cadastro, 
    id_plano, 
    id_atividade, 
    data_cancelamento
FROM FITNESSLIFE.DBO.CLIENTE;


-- 4. Desliga a permissão
SET IDENTITY_INSERT BRONZE_CLIENTE OFF;



--=====================================
--   CARGA_BRONZE_PLANO_PRECO
--=====================================


CREATE PROCEDURE CARGA_BRONZE_PLANO_PRECO -- QUANDO ALGUEM APAGAR ALGUMA TABELA, ELE GERA TUDO DENOVO.
AS

---------------------------------------------------------------
--- VERIFICA SE O SCHEMA EXISTE, SE NÃO EXISTIR ELE CRIA
----------------------------------------------------------------

if object_id ('bronze_plano_precos') is not null
DROP TABLE bronze_plano_precos

CREATE TABLE bronze_plano_precos (
    id_plano INT,
    nome_plano VARCHAR(50),
    ano INT,
    valor DECIMAL(10,2),
    PRIMARY KEY (id_plano, ano)
);

---------------------------------------------------------------
---LIMPA ÁREA
----------------------------------------------------------------

TRUNCATE TABLE BRONZE_PLANO_PRECOS

---------------------------------------------------------------
--- POPULANDO AREA
----------------------------------------------------------------

INSERT INTO BRONZE_PLANO_PRECOS
SELECT *FROM FITNESSLIFE.DBO.PLANO_PRECOS




--=====================================
--   CARGA_BRONZE_DATA
--=====================================


CREATE PROCEDURE CARGA_BRONZE_DATA -- QUANDO ALGUEM APAGAR ALGUMA TABELA, ELE GERA TUDO DENOVO.
AS

---------------------------------------------------------------
--- VERIFICA SE O SCHEMA EXISTE, SE NÃO EXISTIR ELE CRIA
----------------------------------------------------------------



if object_id ('bronze_data') is not null
DROP TABLE bronze_data

CREATE TABLE bronze_data (
    data DATE PRIMARY KEY,
    ano INT,
    mes INT,
    nome_mes VARCHAR(20)
);

---------------------------------------------------------------
---LIMPA ÁREA
----------------------------------------------------------------

TRUNCATE TABLE BRONZE_DATA

---------------------------------------------------------------
--- POPULANDO AREA
----------------------------------------------------------------

INSERT INTO BRONZE_DATA 
SELECT *FROM FITNESSLIFE.DBO.DATA

EXEC CARGA_BRONZE_DATA


--=====================================
--   CARGA_BRONZE_RECEITA
--=====================================


CREATE PROCEDURE CARGA_BRONZE_RECEITA -- QUANDO ALGUEM APAGAR ALGUMA TABELA, ELE GERA TUDO DENOVO.
AS

---------------------------------------------------------------
--- VERIFICA SE O SCHEMA EXISTE, SE NÃO EXISTIR ELE CRIA
----------------------------------------------------------------

if object_id ('bronze_receita') is not null
DROP TABLE bronze_receita

CREATE TABLE bronze_receita (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT,
    id_plano INT,
    id_atividade INT,
    data DATE,
    receita DECIMAL(10,2)
);

---------------------------------------------------------------
---LIMPA ÁREA
----------------------------------------------------------------

TRUNCATE TABLE BRONZE_RECEITA

---------------------------------------------------------------
--- POPULANDO AREA
----------------------------------------------------------------

-- Limpa a tabela bronze antes de carregar
TRUNCATE TABLE BRONZE_RECEITA;

-- 1. Abre a permissão para inserir o ID manual
SET IDENTITY_INSERT BRONZE_RECEITA ON;

-- 2. Insere com TABLOCK para ser ultra rápido
INSERT INTO BRONZE_RECEITA WITH (TABLOCK) (id, id_cliente, id_plano, id_atividade, data, receita)
SELECT id, id_cliente, id_plano, id_atividade, data, receita
FROM FITNESSLIFE.DBO.RECEITA;

-- 3. Fecha a permissão (Obrigatório)
SET IDENTITY_INSERT BRONZE_RECEITA OFF;
