/* ============================================================================
PROJETO: FitLife Data Warehouse
ETAPA: Transformação e Carga da Camada Silver (Tabela Receita)
DESCRIÇÃO:Procedure para automação do pipeline de dados da camada Bronze para a Silver.

A lógica consiste em:
1. Limpeza (TRUNCATE) dos dados antigos da tabela Silver.
2. Habilitação de IDENTITY_INSERT para preservar as chaves de origem.
3. Tratamento de nulos nas chaves estrangeiras (substituição por 0).
4. Conversão e garantia do tipo DATE para o campo de data.
5. Ajuste de precisão numérica para o valor da receita (DECIMAL).
=============================================================================*/

CREATE OR ALTER PROCEDURE USP_CARGA_SILVER_RECEITA

AS
BEGIN


-- 1. LIMPEZA: Como a tabela já existe, apenas limpamos os dados antigos
TRUNCATE TABLE SILVER_RECEITA;

-- 2. Permite inserir o ID que vem da base original
SET IDENTITY_INSERT SILVER_RECEITA ON;

-- 3. Insere os dados listando as colunas (obrigatório quando tem Identity)
INSERT INTO SILVER_RECEITA (
	id,
	id_cliente,
	id_plano,
	id_atividade,
	data,
	receita
)

SELECT 
	id,
	ISNULL (id_cliente,0)			as id_cliente,
	isnull (id_plano,0)				as id_plano,
	isnull (id_atividade,0)			as id_atividade,
	cast (data as date)				as data,
	cast(receita as decimal (10,2))	as receita
	
FROM DBO.bronze_receita

END
