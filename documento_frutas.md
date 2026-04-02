%md
# Analise de Dados em SQL

### Pratica em analise de dados em sql baseada no livro "SQL FOR DATA ANALISYS"
_obs: Há arquivos com script para criar todas as tabelas e script com código para criar e também o código da analise, mas da para acompanhar tudo aqui_

### Preparando os dados para a analise: 
Então, a maioria do tempo de trabalho para um analista de dados é tratando os dados, preparando para a analise, conhecendo os dados. E sobre isso veremos abaixo

No livro Ensina como é importante conhecer quais tipos de dados existe em SQL

| Tipo     | Nome                    | Descrição |
|----------|-------------------------|-----------|
| String   | CHAR / VARCHAR          | Armazena cadeias de caracteres (strings). O CHAR tem tamanho fixo, enquanto o VARCHAR tem tamanho variável, até um tamanho máximo definido (por exemplo, 256 caracteres). |
|          | TEXT / BLOB             | Armazena textos mais longos que não cabem em um VARCHAR. Descrições ou textos livres inseridos por respondentes de questionários podem ser armazenados nesses campos. |
| Numérico | INT / SMALLINT / BIGINT | Armazena números inteiros. Alguns bancos de dados possuem SMALLINT e/ou BIGINT. O SMALLINT pode ser usado quando o campo armazenará apenas valores com poucos dígitos, ocupando menos memória que um INT. O BIGINT suporta números com mais dígitos que o INT, porém ocupa mais espaço. |
|          | FLOAT / DOUBLE / DECIMAL | Armazena números decimais, às vezes com a quantidade de casas decimais especificada. |
| Lógico   | BOOLEAN                 | Armazena valores VERDADEIRO (TRUE) ou FALSO (FALSE). |
|          | DATETIME / TIMESTAMP    | Armazena datas com hora. Geralmente no formato YYYY-MM-DD hh:mm:ss, onde YYYY é o ano (4 dígitos), MM é o mês, DD é o dia, hh é a hora (formato 24h), mm são os minutos e ss são os segundos. Alguns bancos armazenam timestamps sem fuso horário, enquanto outros possuem tipos específicos com e sem fuso horário. |
|      Hora    | TIME                    | Armazena apenas horários. |

O livro também ensina sobre dados estruturado e não estruturados, e sobre dados quantitativos e qualitatitvos, mas a codificação começa no assunto sobre a frequencia e a distribuição e a frequencia dos dados, é importante no conhecimento descobrir quais são as frequencia dos dados, pois vendo a frequencia consegue ter uma ideia da quantidade de cada campos (quem tem mais, quem tem menos), porque tem essa quantidade, quais são os outiliers, esta pronto para ser aplicado em um modelo de machine learning, etc...

Nesse tópico, começa a codificação e ensina a usar a função _COUNT()_ que conta a quantidade de um campo que foi pedido

#### tabela:
| id | fruit  | quantity | supplier | arrival_date |
|----|--------|----------|----------|--------------|
| 1  | apple  | 10       | Farm A   | 2024-01-03   |
| 2  | apple  | 7        | Farm B   | 2024-01-05   |
| 3  | banana | 12       | Farm A   | 2024-01-03   |
| 4  | banana | 5        | Farm C   | 2024-01-06   |
| 5  | orange | 8        | Farm B   | 2024-01-04   |
| 6  | orange | 6        | Farm B   | 2024-01-08   |
| 7  | grape  | 3        | Farm C   | 2024-01-07   |
| 8  | apple  | 4        | Farm A   | 2024-01-09   |
| 9  | banana | 9        | Farm B   | 2024-01-10   |
| 10 | grape  | 6        | Farm A   | 2024-01-11   |

_obs: a mais dados, esses são so demonstrativos_

#### código:
```
SELECT fruit, count(*) as quantity
FROM fruit_inventory
GROUP BY 1 -- ou fruit
;

```

### resultado:
| fruit  | quantity |
|--------|----------|
| apple  | 8        |
| banana | 7        |
| grape  | 4        |
| orange | 7        |
| pear   | 4        |

Na coluna 'fruit' há 8 maçã, 7 bananas, 4 uvas etc...,pois a função _COUNT()_ está contando quantas vezes aparece  entenderam a sacada? agora vamos fazer um codigo que mostra a quantidade de cada fruta

#### código:
```
SELECT 
	fruit, 
	SUM(quantity) AS quantidade_total_frutas
FROM fruit_inventory
GROUP BY fruit
;
```

#### resultado:
| fruit  | quantity |
|--------|----------|
| apple  | 76       |
| banana | 70       |
| grape  | 21       |
| orange | 57       |
| pear   | 28       |

Conseguem ver a diferença? um dos codigos contou as linhas, tem até esse sinal (*) siginifica todas as colunas, porém no ultimo código especificou a coluna 'quantity' e somou utilizando a função _SUM()_

_OBS: Uma função muito importante foi o GRUOP BY(), essa função serve para agrupar os resultados de acordo com a com a coluna que foi pedida para ser agruada_

Esse dataset é pequeno, mas conseguimos tirar muitas informações por exemplo "quantidade de frutas por mês"

#### quantidade de frutas por mês:

#### código
```
SELECT 
	fruit,
	STRFTIME('%m', arrival_date) AS month, -- No POSTGRESQL/SQL SERVER = DATE_TRUNC() e no MYSQL = DATE_FORMAT()
	SUM(quantity) AS quantidade_de_frutas
FROM 
	fruit_inventory
GROUP BY 
	month, fruit 
;
```

#### resultado:
| fruit  | month | quantidade_de_frutas |
|--------|-------|----------------------|
| apple  | 01    | 33                   |
| banana | 01    | 26                   |
| grape  | 01    | 9                    |
| orange | 01    | 24                   |
| pear   | 01    | 12                   |
| apple  | 02    | 17                   |
| banana | 02    | 25                   |
| grape  | 02    | 4                    |
| orange | 02    | 16                   |
| pear   | 02    | 6                    |
| apple  | 03    | 26                   |

Porém, não tá tão legal a vizualização né? nesse caso, é bom vizualizar por frutas (exemplo: só banana) ou vizualizando a quantidade geral de um determinado mês

#### código:

```
SELECT
    fruit,
    STRFTIME('%m', arrival_date) AS month,
    SUM(quantity) AS quantidade_de_frutas
FROM 
    fruit_inventory
WHERE 
    fruit = 'banana'
GROUP BY 
    fruit,
    STRFTIME('%m', arrival_date)
;
```
#### resultado:
| fruit  | month | quantidade_de_frutas |
|--------|-------|----------------------|
| banana | 01    | 26                   |
| banana | 02    | 25                   |
| banana | 03    | 19                   |

_OBS: Aqui foi ultilizado o WHERE, uma função que serve como condição, por exemplo nessa tabela so apareceu dados que é igual a "banana" na tabela 'fruit'_
