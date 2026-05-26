
/*
=============================================================================
PROJETO: FitLife Data Warehouse
ETAPA: Definição da Camada Gold (Schema)
DESCRIÇÃO: 
    Este script cria a estrutura física das tabelas na camada Gold.
    A lógica consiste em:
    1. Validar a existência de tabelas anteriores (DROP se necessário).
    2. Criar tabelas de dimensões e fatos otimizadas para consumo analítico.
    3. Garantir a integridade referencial por meio de chaves estrangeiras.
=============================================================================
*/

USE FITNESSLIFE_DW;
GO

-- ============================================
-- TABELA CLIENTES
-- ============================================

if object_id ('dim_cliente') is not null
DROP TABLE dim_cliente

CREATE TABLE dim_cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,  
    nome_cliente VARCHAR(100),
    cidade VARCHAR(50),
    data_cadastro DATE,
    status varchar (10),
    faixa_etaria VARCHAR (15),
    meses_fidelidade int
);



-- ============================================
-- ATIVIDADES/PRODUTOS
-- ============================================
if object_id ('dim_atividade') is not null
DROP TABLE dim_atividade

CREATE TABLE dim_atividade (
    id_atividade INT PRIMARY KEY,
    tipo_atividade VARCHAR(50)
);

-- ============================================
-- PLANOS
-- ============================================

if object_id ('dim_plano') is not null
DROP TABLE dim_plano

CREATE TABLE dim_plano (
    id_plano INT primary key,
    nome_plano VARCHAR(50)
   
);


-- ============================================
-- RECEITA
-- ============================================
if object_id ('fato_receita') is not null
DROP TABLE fato_receita

CREATE TABLE fato_receita (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT,
    id_plano INT,
    id_atividade INT,
    data DATE,
    receita DECIMAL(10,2)

      -- Integridade Referencial na Fato
    CONSTRAINT FK_fato_receita_cliente FOREIGN KEY (id_cliente) REFERENCES dim_cliente(id_cliente),
    CONSTRAINT FK_fato_receita_plano FOREIGN KEY (id_plano) REFERENCES dim_plano(id_plano),
    CONSTRAINT FK_fato_receita_atividade FOREIGN KEY (id_atividade) REFERENCES dim_atividade(id_atividade),
    CONSTRAINT FK_fato_receita_data FOREIGN KEY (data) REFERENCES dim_data(data)
);
GO

-- ============================================
-- CALENDARIO
-- ============================================

if object_id ('dim_data') is not null
DROP TABLE dim_data

CREATE TABLE dim_data (
    data DATE PRIMARY KEY,
    ano INT,
    mes INT,
    nome_mes VARCHAR(20)
);

GO
