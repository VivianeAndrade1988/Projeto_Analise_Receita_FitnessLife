
/*=====================================================
SCRIPT: CRIAÇÃO DO BANCO DATAWAREHOUSE
=====================================================*/

-- Verifica se banco já existe
IF DB_ID('DATAWAREHOUSE') IS NOT NULL
BEGIN
    DROP DATABASE DATAWAREHOUSE
END
GO

-- Cria novo banco
CREATE DATABASE DATAWAREHOUSE
GO

-- Usa banco criado
USE DATAWAREHOUSE
GO
