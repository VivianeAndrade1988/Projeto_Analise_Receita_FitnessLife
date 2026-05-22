
/*
=============================================================================
PROJETO: FitLife Data Warehouse
ETAPA: Definição da Camada Bronze (Schema)
DESCRIÇÃO: 
    Este script cria a estrutura física das tabelas na área Bronze.
    A lógica consiste em:
    1. Validar a existência de tabelas anteriores (DROP se necessário).
    2. Criar tabelas com o prefixo 'bronze_' replicando a tipagem da origem.
    3. Preparar o ambiente para o recebimento da carga bruta (Landing Zone).
=============================================================================
*/

use FITNESSLIFE_DW

-- ============================================
-- TABELA CLIENTES
-- ============================================

if object_id ('bronze_cliente') is not null
DROP TABLE bronze_cliente

CREATE TABLE bronze_cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,  -- ?? AQUI ESTÁ A CORREÇÃO
    nome_cliente VARCHAR(100),
    idade INT,
    cidade VARCHAR(50),
    data_cadastro DATE,
    id_plano INT,
    id_atividade INT,
    data_cancelamento DATE
);

-- ============================================
-- ATIVIDADES/PRODUTOS
-- ============================================
if object_id ('bronze_atividade') is not null
DROP TABLE bronze_atividade

CREATE TABLE bronze_atividade (
    id_atividade INT PRIMARY KEY,
    tipo_atividade VARCHAR(50)
);

-- ============================================
-- PLANOS_PRECOS
-- ============================================

if object_id ('bronze_plano_precos') is not null
DROP TABLE bronze_plano_precos

CREATE TABLE bronze_plano_precos (
    id_plano INT,
    nome_plano VARCHAR(50),
    ano INT,
    valor DECIMAL(10,2),
    PRIMARY KEY (id_plano, ano)
);

-- ============================================
-- POPULANDO TABELA BRONZE_ATIVIDADE
-- ============================================

TRUNCATE TABLE BRONZE_ATIVIDADE;

INSERT INTO BRONZE_ATIVIDADE
SELECT *FROM FITNESSLIFE.DBO.ATIVIDADE

-- ============================================
-- CALENDARIO
-- ============================================

if object_id ('bronze_data') is not null
DROP TABLE bronze_data

CREATE TABLE bronze_data (
    data DATE PRIMARY KEY,
    ano INT,
    mes INT,
    nome_mes VARCHAR(20)
);

-- ============================================
-- RECEITA
-- ============================================

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
