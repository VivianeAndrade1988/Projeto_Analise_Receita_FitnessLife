
/*
==============================================================================
PROJETO: FitLife Data Warehouse
ETAPA: Transformação e Carga da Camada Silver (Tabela Atividade)
DESCRIÇÃO:Procedure para automação do pipeline de dados da camada Bronze para a Silver.

A lógica consiste em:
1. Limpeza (TRUNCATE) dos dados antigos da tabela Silver.
2. Habilitação de IDENTITY_INSERT para preservar as chaves de origem.
3. Validação do ID da atividade para garantir que seja positivo.
4. Padronização de textos (TRIM) e tratamento de valores nulos.
5. Filtro de integridade para ignorar registros sem identificação.
=============================================================================*/

CREATE OR ALTER PROCEDURE USP_CARGA_SILVER_ATIVIDADE

AS
BEGIN

-- 1. LIMPEZA: Como a tabela já existe, apenas limpamos os dados antigos
TRUNCATE TABLE SILVER_ATIVIDADE;

-- 2. Permite inserir o ID que vem da base original
SET IDENTITY_INSERT SILVER_ATIVIDADE ON;

-- 3. Insere os dados listando as colunas (obrigatório quando tem Identity)
INSERT INTO SILVER_ATIVIDADE (
	id_atividade,
	tipo_atividade
)

SELECT 
 -- 1. Garante que o ID é válido (se for <= 0, vira NULL ou você pode filtrar 
	CASE 
	WHEN id_atividade <= 0 THEN NULL
	ELSE id_atividade
END AS id_atividade,

-- 2. Limpa espaços, padroniza em maiúsculo e trata nulos

isnull(trim(tipo_atividade), 'Não informado') as tipo_atividade

from dbo.bronze_atividade

WHERE id_atividade IS NOT NULL; -- Filtro básico de integridade

end
