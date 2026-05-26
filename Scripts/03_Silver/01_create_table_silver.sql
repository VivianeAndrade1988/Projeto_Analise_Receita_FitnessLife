

---CRIANDO TABELAS SILVER

use FITNESSLIFE_DW

-- ============================================
-- TABELA CLIENTES
-- oBS: Foram acrescentadas 3 colunas: status, faixa_etaria e meses_fidelidade
-- ============================================

if object_id ('SILVER_cliente') is not null
DROP TABLE SILVER_cliente

CREATE TABLE SILVER_cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,  
    nome_cliente VARCHAR(100),
    idade INT,
    cidade VARCHAR(50),
    data_cadastro DATE,
    id_plano INT,
    id_atividade INT,
    data_cancelamento DATE,
    status varchar (10),
    faixa_etaria VARCHAR (15),
    meses_fidelidade int
);



-- ============================================
-- ATIVIDADES/PRODUTOS
-- ============================================
if object_id ('SILVER_atividade') is not null
DROP TABLE SILVER_atividade

CREATE TABLE SILVER_atividade (
    id_atividade INT PRIMARY KEY,
    tipo_atividade VARCHAR(50)
);

-- ============================================
-- PLANOS_PRECOS
-- ============================================

if object_id ('SILVER_plano_precos') is not null
DROP TABLE SILVER_plano_precos

CREATE TABLE SILVER_plano_precos (
    id_plano INT,
    nome_plano VARCHAR(50),
    ano INT,
    valor DECIMAL(10,2),
    PRIMARY KEY (id_plano, ano)
);


-- ============================================
-- RECEITA
-- ============================================
if object_id ('SILVER_receita') is not null
DROP TABLE SILVER_receita

CREATE TABLE SILVER_receita (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT,
    id_plano INT,
    id_atividade INT,
    data DATE,
    receita DECIMAL(10,2)
);

-- ============================================
-- CALENDARIO
-- ============================================

if object_id ('SILVER_data') is not null
DROP TABLE SILVER_data

CREATE TABLE SILVER_data (
    data DATE PRIMARY KEY,
    ano INT,
    mes INT,
    nome_mes VARCHAR(20)
);
