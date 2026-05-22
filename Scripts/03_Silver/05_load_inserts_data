
/*
========================================================++++++++++++==========
PROJETO: FitLife Data Warehouse
ETAPA: Transformação e Carga da Camada Silver (Tabela Data)
DESCRIÇÃO:Procedure para automação do pipeline de dados da camada Bronze para a Silver.
A lógica consiste em:
1. Limpeza (TRUNCATE) dos dados antigos da tabela Silver.
2. Conversão e garantia do tipo DATE para o campo de data.
3. Extração e reavaliação do ano e do mês com base na data real.
4. Padronização do nome do mês para abreviação de 3 caracteres.
=============================================================================*/


CREATE OR ALTER PROCEDURE USP_CARGA_SILVER_DATA

AS
BEGIN


-- 1. LIMPEZA: Como a tabela já existe, apenas limpamos os dados antigos
TRUNCATE TABLE SILVER_DATA;


-- 2. Insere os dados listando as colunas (obrigatório quando tem Identity)
INSERT INTO SILVER_DATA (
	data,
	ano,
	mes,
	nome_mes
)


SELECT 
	cast (data as date) as data, -- garante tipo Date
	year (data) as ano, --reavalia o ano com base na data real
	month (data) as mes, -- reavalia o mes (1 a 12)
	left (nome_mes,3) as nome_mes -- retorna jan, fev...

FROM dbo.bronze_data

end
