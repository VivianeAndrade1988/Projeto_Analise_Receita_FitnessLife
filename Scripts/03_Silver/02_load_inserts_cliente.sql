/* ============================================================================
PROJETO: FitnessLife Data Warehouse
ETAPA: Transformação e Carga da Camada Silver (Tabela Cliente)
DESCRIÇÃO:Procedure para automação do pipeline de dados da camada Bronze para a Silver.
A lógica consiste em:
1. Limpeza (TRUNCATE) dos dados antigos da tabela Silver.
2. Habilitação de IDENTITY_INSERT para preservar as chaves de origem.
3. Padronização de textos (TRIM) e tratamento de nulos (ISNULL).
4. Saneamento da idade com aplicação de regras de negócio (0 a 100 anos).
5. Criação de regras de negócio: Status do cliente e Faixa Etária.
6. Cálculo de métrica de tempo de permanência (meses de fidelidade).
--=============================================================================*/


CREATE OR ALTER PROCEDURE USP_CARGA_SILVER_CLIENTE
AS
BEGIN


-- 1. LIMPEZA: Como a tabela já existe, apenas limpamos os dados antigos
TRUNCATE TABLE SILVER_CLIENTE;

-- 2. Permite inserir o ID que vem da base original
SET IDENTITY_INSERT SILVER_CLIENTE ON;

-- 3. Insere os dados listando as colunas (obrigatório quando tem Identity)
INSERT INTO SILVER_CLIENTE (
    id_cliente, 
    nome_cliente, 
    idade, 
    cidade, 
    data_cadastro, 
    id_plano, 
    id_atividade, 
    data_cancelamento,
    status,
    faixa_etaria,
    meses_fidelidade
)


SELECT 
   	id_cliente,
	ISNULL (trim (nome_cliente),'Nao Informado') AS nome_cliente,

CASE 
    WHEN idade <= 0 OR idade > 100 THEN NULL -- Se a data for menor que 0 ou maior que 100, traga null
    ELSE idade 
END AS idade,
	isnull (trim (cidade),'Não Informada') as cidade, -- Se a cidade for null traga 'Não informada', 
	data_cadastro,
	id_plano,
	id_atividade,
	
    CASE 
        WHEN data_cancelamento < data_cadastro THEN NULL 
        ELSE data_cancelamento 
    END AS data_cancelamento,

case when data_cancelamento is null then 'Ativo' -- criamos coluna
	else 'Cancelou'
end 'Status',

CASE -- criando faixa etaria
    WHEN idade < 18 THEN 'Até 17 anos'
    WHEN idade BETWEEN 18 AND 35 THEN '18-35 anos'
    WHEN idade BETWEEN 36 AND 50 THEN '36-50 anos'
    ELSE '+ de 50 anos'
END AS faixa_etaria,

 DATEDIFF(
        MONTH, 
        data_cadastro, 
        ISNULL(
            CASE WHEN data_cancelamento < data_cadastro THEN NULL ELSE data_cancelamento END, 
            GETDATE()
        )
    ) AS meses_fidelidade

FROM DBO.BRONZE_CLIENTE


end
