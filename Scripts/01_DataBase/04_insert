
/* ============================================================================
As tabelas foram criadas com um cenário já montado por mim, com ajuda da IA.
===============================================================================*/

-- ============================================
-- POPULANDO TABELA CLIENTES
-- ============================================


WITH nomes AS (
    SELECT nome FROM (VALUES 
    ('Ana'),('Bruno'),('Carla'),('Daniel'),('Eduardo'),('Fernanda'),('Gabriel'),('Helena'),('Igor'),('Juliana'),
    ('Lucas'),('Mariana'),('Nicolas'),('Patricia'),('Rafael'),('Sandra'),('Thiago'),('Vanessa'),('William'),('Aline'),
    ('Carlos'),('Débora'),('Felipe'),('Gustavo'),('Isabela'),('João'),('Karen'),('Leandro'),('Marcelo'),('Natália'),
    ('Otávio'),('Paula'),('Renato'),('Simone'),('Tatiane'),('Vinicius'),('Yasmin'),('Brenda'),('Caio'),('Diego'),
    ('Beatriz'),('Leonardo'),('Larissa'),('Marcos'),('Priscila'),('Ricardo'),('Tânia'),('Hugo'),('Vitor'),('Cecília')
    ) AS t(nome)
),
sobrenomes AS (
    SELECT sobrenome FROM (VALUES 
    ('Silva'),('Santos'),('Oliveira'),('Souza'),('Rodrigues'),('Ferreira'),('Alves'),('Pereira'),('Lima'),('Gomes'),
    ('Costa'),('Ribeiro'),('Martins'),('Carvalho'),('Almeida'),('Lopes'),('Soares'),('Fernandes'),('Vieira'),('Barbosa'),
    ('Rocha'),('Dias'),('Teixeira'),('Moreira'),('Correia'),('Cardoso'),('Batista'),('Freitas'),('Moura'),('Rezende'),
    ('Mendes'),('Nunes'),('Moraes'),('Aragão'),('Duarte'),('Cavalcanti'),('Pinto'),('Guimarães'),('Farias'),('Borges')
    ) AS t(sobrenome)
),
CombinacoesAleatorias AS (
    SELECT 
        CONCAT(n.nome, ' ', s1.sobrenome, ' ', s2.sobrenome) AS nome_completo,
        ROW_NUMBER() OVER (ORDER BY NEWID()) AS seq
    FROM nomes n
    CROSS JOIN sobrenomes s1
    CROSS JOIN sobrenomes s2
    WHERE s1.sobrenome <> s2.sobrenome
),
DadosBase AS (
    SELECT TOP 1200
        nome_completo,
        18 + ABS(CHECKSUM(NEWID())) % 50 AS idade,
        CASE 
            WHEN ABS(CHECKSUM(NEWID())) % 100 < 50 THEN 'São Paulo'
            WHEN ABS(CHECKSUM(NEWID())) % 100 < 75 THEN 'Campinas'
            ELSE 'Sorocaba'
        END AS cidade,
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1826, '2019-01-01') AS data_cadastro,
        CASE 
            WHEN ABS(CHECKSUM(NEWID())) % 100 < 50 THEN 1
            WHEN ABS(CHECKSUM(NEWID())) % 100 < 80 THEN 2
            ELSE 3
        END AS id_plano,
        (ABS(CHECKSUM(NEWID())) % 5) + 1 AS id_atividade,
        seq
    FROM CombinacoesAleatorias
)

INSERT INTO Cliente (nome_cliente, idade, cidade, data_cadastro, id_plano, id_atividade, data_cancelamento)
SELECT 
    nome_completo,
    idade,
    cidade,
    data_cadastro,
    id_plano,
    id_atividade,
    CASE 
        -- GERA OS 3 ERROS PROPOSITAIS (Data cancelamento = Cadastro menos 1 ano)
        WHEN seq <= 3 THEN DATEADD(YEAR, -1, data_cadastro)
        
        -- GERA DADOS CORRETOS (Data cancelamento = Cadastro + alguns dias) para 20% da base
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 20 THEN 
            DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, data_cadastro)
            
        ELSE NULL
    END AS data_cancelamento
FROM DadosBase
ORDER BY seq;

-- ============================================
-- POPULANDO TABELA ATIVIDADES/PRODUTOS
-- ============================================

INSERT INTO atividade VALUES
(1, 'Musculação'),
(2, 'Funcional'),
(3, 'Cross Training'),
(4, 'Yoga'),
(5, 'Dança');


-- ============================================
-- POPULANDO TABELA PLANO_PRECOS
-- ============================================

INSERT INTO plano_precos (id_plano, nome_plano, ano, valor) VALUES

-- Plano Básico (Base 99.90)
(1, 'Básico', 2019, 99.90),
(1, 'Básico', 2020, 99.90),
(1, 'Básico', 2021, 104.90),
(1, 'Básico', 2022, 109.90),
(1, 'Básico', 2023, 114.90),

-- Plano Standard (Base 149.90)
(2, 'Standard', 2019, 149.90),
(2, 'Standard', 2020, 149.90),
(2, 'Standard', 2021, 154.90),
(2, 'Standard', 2022, 159.90),
(2, 'Standard', 2023, 164.90),

-- Plano Premium (Base 199.90)
(3, 'Premium', 2019, 199.90),
(3, 'Premium', 2020, 199.90),
(3, 'Premium', 2021, 209.90),
(3, 'Premium', 2022, 219.90),
(3, 'Premium', 2023, 229.90);

-- ============================================
-- POPULANDO CALENDARIO
-- ============================================

TRUNCATE TABLE data;

DECLARE @data DATE = '2019-01-01';

WHILE @data <= '2023-12-31'
BEGIN
    INSERT INTO data VALUES (
        @data,
        YEAR(@data),
        MONTH(@data),
        DATENAME(MONTH, @data)
    );

    SET @data = DATEADD(DAY, 1, @data);
END;


-- ============================================
-- POPULANDO TABELA RECEITA
-- ============================================

-- ============================================
-- MESES
-- ============================================
WITH meses AS (
    SELECT DATEFROMPARTS(2019,1,1) AS data_ref

    UNION ALL

    SELECT DATEADD(MONTH, 1, data_ref)
    FROM meses
    WHERE data_ref < '2023-12-01'
)

-- ============================================
-- FATO RECEITA
-- ============================================
INSERT INTO receita (
    id_cliente,
    id_plano,
    id_atividade,
    data,
    receita
)

SELECT
    c.id_cliente,
    c.id_plano,
    c.id_atividade,
    m.data_ref,

    (
        p.valor

        -- Crescimento natural da empresa até 2022
        * CASE 
            WHEN YEAR(m.data_ref) = 2019 THEN 1.00
            WHEN YEAR(m.data_ref) = 2020 THEN 1.08
            WHEN YEAR(m.data_ref) = 2021 THEN 1.15
            WHEN YEAR(m.data_ref) = 2022 THEN 1.25
            
            -- Queda geral da operação em 2023
            WHEN YEAR(m.data_ref) = 2023 THEN 0.85
          END

        -- Pequena variação natural
        * (0.97 + (ABS(CHECKSUM(NEWID())) % 6) / 100.0)

    ) AS receita

FROM cliente c

CROSS JOIN meses m

JOIN plano_precos p
    ON p.id_plano = c.id_plano
   AND p.ano = YEAR(m.data_ref)

WHERE 

-- Receita começa após cadastro do cliente
DATEFROMPARTS(
    YEAR(m.data_ref),
    MONTH(m.data_ref),
    1
) >= DATEFROMPARTS(
    YEAR(c.data_cadastro),
    MONTH(c.data_cadastro),
    1
)

AND

-- Receita termina no cancelamento
DATEFROMPARTS(
    YEAR(m.data_ref),
    MONTH(m.data_ref),
    1
) <= DATEFROMPARTS(
    YEAR(
        CASE 
            WHEN c.data_cancelamento IS NULL THEN '2023-12-31'

            -- Corrige erro proposital da base
            WHEN c.data_cancelamento < c.data_cadastro THEN '2023-12-31'

            ELSE c.data_cancelamento
        END
    ),
    MONTH(
        CASE 
            WHEN c.data_cancelamento IS NULL THEN '2023-12-31'

            WHEN c.data_cancelamento < c.data_cadastro THEN '2023-12-31'

            ELSE c.data_cancelamento
        END
    ),
    1
)

-- ============================================
-- CROSS TRAINING ENCERRADO APÓS FEVEREIRO/2023
-- ============================================
AND NOT (
    c.id_atividade = 3
    AND m.data_ref >= '2023-03-01'
)

OPTION (MAXRECURSION 0);

-- ============================================
-- VALIDAÇÃO
-- ============================================

SELECT *
FROM receita
WHERE id_cliente = 3;

-- ============================================
-- VALIDAR QUEDA DO CROSS EM 2023
-- ============================================

SELECT
    YEAR(data) AS ano,
    MONTH(data) AS mes,
    id_atividade,
    SUM(receita) AS receita_total
FROM receita
WHERE id_atividade = 3
GROUP BY
    YEAR(data),
    MONTH(data),
    id_atividade
ORDER BY ano, mes;
