
/*PROJETO: FitLife Data Warehouse
ETAPA: Transformação e Carga da Camada Silver (Tabela Plano Preços)
DESCRIÇÃO:Procedure para automação do pipeline de dados da camada Bronze para a Silver.
A lógica consiste em:1. 
Limpeza (TRUNCATE) dos dados antigos da tabela Silver.
2. Habilitação de IDENTITY_INSERT para preservar as chaves de origem.
3. Padronização de textos (TRIM) no nome do plano.
4. Saneamento do ano para garantir valores lógicos (posteriores a 2000).
5. Tratamento de valores negativos (conversão para absoluto) e nulos.
6. Filtro de integridade para ignorar registros sem ID ou sem ano.
=============================================================================*/

CREATE OR ALTER PROCEDURE USP_CARGA_SILVER_PLANO_PRECOS

AS
BEGIN


-- 1. LIMPEZA: Como a tabela já existe, apenas limpamos os dados antigos
TRUNCATE TABLE SILVER_PLANO_PRECOS;

-- 2. Permite inserir o ID que vem da base original
SET IDENTITY_INSERT SILVER_PLANO_PRECOS ON;

-- 3. Insere os dados listando as colunas (obrigatório quando tem Identity)
INSERT INTO SILVER_PLANO_PRECOS (
	id_plano,
	nome_plano,
	ano,
	valor
)


select 
	id_plano,
	trim(nome_plano) as nome_plano,

	-- Garantia de que o ano é um valor lógico
	case	
		when ano< 2000 then null
		else ano
	end as ano,

	-- Tratamento de valores negativos (converte para absoluto ou zero)
	case	
		when valor<0 then abs(valor)
		else isnull (valor,0)
	end as valor

from dbo.bronze_plano_precos 
WHERE id_plano IS NOT NULL AND ano IS NOT NULL; -- Chave primária não pode ser nula

end
