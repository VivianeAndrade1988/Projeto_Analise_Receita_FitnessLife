# 📊 Power BI | Analytics

Documentação analítica do dashboard desenvolvido no Power BI.

---

# 🎯 Objetivo

Transformar dados do Data Warehouse em análises executivas e insights estratégicos sobre receita, monetização e performance operacional.

---

# 📌 Dashboard Desenvolvido

<img width="800" height="510" alt="Captura de tela 2026-05-20 131025" src="https://github.com/user-attachments/assets/52a428e8-3e2f-444a-9e70-1868775b74a7" />


---

# 📈 KPIs Desenvolvidos

| KPI | Objetivo |
|---|---|
| Receita Total | Receita geral |
| Clientes Ativos | Quantidade de clientes |
| Ticket Médio | Receita por cliente |
| Crescimento YoY | Crescimento anual |
| Impacto Receita | Diferença financeira |

---

# 📊 Visualizações Desenvolvidas

✅ Evolução da Receita vs Ano Anterior  
✅ Clientes vs Ticket Médio  
✅ Receita por Plano  
✅ Receita por Atividade  
✅ Impacto Financeiro  
✅ Navegação Analítica  

---
## Receita ao longo do tempo
<img width="500" height="300" alt="receita" src="https://github.com/user-attachments/assets/8ef2b882-0de1-41ef-a78c-262e87628841" />


---

## Clientes vs Ticket Médio

<img width="500" height="300" alt="ticket medio" src="https://github.com/user-attachments/assets/2a22eac8-0633-4804-aabf-58f0c5343d17" />


---

## Receita por atividade
- receita_atividade.png

<img width="500" height="300" alt="image" src="https://github.com/user-attachments/assets/904f5f07-4637-45e1-b918-c55112ce5937" />


---
## Impacto financeiro das atividades

<img width="500" height="300" alt="impacto" src="https://github.com/user-attachments/assets/4217122d-14f1-4e30-8497-2e47147524d1" />


---
## Receita por plano
<img width="500" height="300" alt="planos" src="https://github.com/user-attachments/assets/8dd776dc-1e0e-4164-b1ad-5fa1e61f8ba0" />

---

# 📐 Principais Medidas DAX

## Receita Total

```DAX
Receita Total =
SUM(gold_fato_receita[receita])
```

---

## Clientes Ativos

```DAX
Clientes Ativos =
DISTINCTCOUNT(gold_fato_receita[id_cliente])
```

---

## Ticket Médio

```DAX
Ticket Médio =
DIVIDE([Receita Total],[Clientes Ativos])
```

---

## Crescimento YoY

```DAX
Crescimento % =
DIVIDE(
    [Receita Total] -
    CALCULATE(
        [Receita Total],
        DATEADD(dim_data[data],-1,YEAR)
    ),
    CALCULATE(
        [Receita Total],
        DATEADD(dim_data[data],-1,YEAR)
    )
)
```

---

# 🧠 Principais Insights Analíticos

- Receita caiu 25% vs 2022
- Ticket médio reduziu 37%
- Clientes cresceram 19%
- Cross Training concentrou maior impacto financeiro negativo
- Queda ocorreu mesmo com expansão da operação

---

# 🎨 Recursos Utilizados

✅ Power BI  
✅ DAX  
✅ Storytelling com Dados  
✅ KPIs Executivos  
✅ Navegação Analítica  
✅ Comparativos Temporais  
✅ Análise Exploratória  
