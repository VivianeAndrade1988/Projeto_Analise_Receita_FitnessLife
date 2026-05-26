
SCRIPT: CRIAÇÃO DOS SCHEMAS
OBJETIVO:
Separar dados por camadas
=====================================================*/

USE DATAWAREHOUSE
GO

-- Camada Bronze = dados crus
CREATE SCHEMA BRONZE
GO

-- Camada Silver = dados tratados
CREATE SCHEMA SILVER
GO

-- Camada Gold = dados analíticos
CREATE SCHEMA GOLD
GO
