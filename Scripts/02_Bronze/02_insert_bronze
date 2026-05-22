

/*
=============================================================================
PROJETO: FitLife Data Warehouse
ETAPA: Carga Inicial de Dados (Manual Load)
DESCRIÇÃO: 
    Script para execução manual da primeira carga de dados para a Bronze.
    A lógica consiste em:
    1. Limpeza (TRUNCATE) das tabelas bronze existentes.
    2. Ingestão simples via INSERT INTO / SELECT para validar conectividade.
    3. Verificação de volumetria de dados importados da base FITLIFE.
=============================================================================
*/

-- ============================================
-- POPULANDO TABELA BRONZE_ATIVIDADE
-- ============================================

TRUNCATE TABLE BRONZE_ATIVIDADE

INSERT INTO BRONZE_ATIVIDADE
SELECT *FROM FITNESSLIFE.DBO.ATIVIDADE

--============================================
-- POPULANDO TABELA BRONZE_CLIENTE

--============================================

TRUNCATE TABLE BRONZE_CLIENTE;

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

--============================================
-- POPULANDO TABELA BRONZE_DATA
--============================================

TRUNCATE TABLE BRONZE_DATA;

INSERT INTO BRONZE_DATA 
SELECT *FROM FITNESSLIFE.DBO.DATA

--============================================
-- POPULANDO TABELA PLANO_PRECOS
--============================================

TRUNCATE TABLE BRONZE_PLANO_PRECOS;

INSERT INTO BRONZE_PLANO_PRECOS
SELECT *FROM FITNESSLIFE.DBO.PLANO_PRECOS

--============================================
-- POPULANDO TABELA RECEITA
--============================================

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
