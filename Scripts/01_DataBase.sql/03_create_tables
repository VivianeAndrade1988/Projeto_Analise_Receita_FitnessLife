

/*
=============================================================================
PROJETO: FitnessLife Data Warehouse
ETAPA: Configuração da Base de Origem (Source)
DESCRIÇÃO: 
    Este script realiza a criação do banco de dados transacional 'FITLIFE'.
    A lógica consiste em:
    1. Criar a base de dados e tabelas (Clientes, Atividades, Planos, Receita).
    2. Gerar massa de dados fictícia via CTEs e lógica aleatória.
    3. Popular tabelas de apoio como Calendário e Atividades.
=============================================================================
*/

-- ============================================
-- TABELA CLIENTES
-- ============================================

CREATE TABLE cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY, 
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

CREATE TABLE atividade (
    id_atividade INT PRIMARY KEY,
    tipo_atividade VARCHAR(50)
);

-- ============================================
-- PLANOS_PRECOS
-- ============================================

CREATE TABLE plano_precos (
    id_plano INT,
    nome_plano VARCHAR(50),
    ano INT,
    valor DECIMAL(10,2),
    PRIMARY KEY (id_plano, ano)
);


-- ============================================
-- CALENDARIO
-- ============================================

CREATE TABLE data (
    data DATE PRIMARY KEY,
    ano INT,
    mes INT,
    nome_mes VARCHAR(20)
);

-- ============================================
-- RECEITA
-- ============================================

CREATE TABLE receita (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT,
    id_plano INT,
    id_atividade INT,
    data DATE,
    receita DECIMAL(10,2)
);
