-- TABELAS DE FRUTAS
CREATE TABLE fruit_inventory (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fruit TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    supplier TEXT,
    arrival_date DATE
);

-- INSERIR DADOS NA TABELA
INSERT INTO fruit_inventory (fruit, quantity, supplier, arrival_date) VALUES
-- January (original + extended)
('apple', 10, 'Farm A', '2024-01-03'),
('apple', 7,  'Farm B', '2024-01-05'),
('banana', 12, 'Farm A', '2024-01-03'),
('banana', 5,  'Farm C', '2024-01-06'),
('orange', 8,  'Farm B', '2024-01-04'),
('orange', 6,  'Farm B', '2024-01-08'),
('grape', 3,   'Farm C', '2024-01-07'),
('apple', 4,   'Farm A', '2024-01-09'),

-- More January data
('banana', 9,  'Farm B', '2024-01-10'),
('grape', 6,   'Farm A', '2024-01-11'),
('orange', 10, 'Farm C', '2024-01-12'),
('apple', 12, 'Farm C', '2024-01-13'),
('pear', 5,    'Farm A', '2024-01-14'),
('pear', 7,    'Farm B', '2024-01-15'),

-- February
('apple', 8,   'Farm A', '2024-02-01'),
('banana', 14, 'Farm A', '2024-02-02'),
('orange', 9,  'Farm B', '2024-02-03'),
('grape', 4,   'Farm C', '2024-02-04'),
('pear', 6,    'Farm B', '2024-02-05'),
('banana', 11, 'Farm C', '2024-02-07'),
('apple', 9,   'Farm B', '2024-02-08'),
('orange', 7,  'Farm A', '2024-02-09'),

-- March
('apple', 15,  'Farm A', '2024-03-01'),
('banana', 13, 'Farm B', '2024-03-02'),
('orange', 12, 'Farm C', '2024-03-03'),
('grape', 8,   'Farm A', '2024-03-04'),
('pear', 10,   'Farm C', '2024-03-05'),
('banana', 6,  'Farm A', '2024-03-06'),
('apple', 11,  'Farm B', '2024-03-07'),
('orange', 5,  'Farm B', '2024-03-08');

-- VIZUALIZAR A TABELA TODA
SELECT * FROM fruit_inventory;

-- CONTAGEM DE FRUTAS POR LINHA
SELECT fruit, count(*) as quantity
FROM fruit_inventory
GROUP BY 1 -- ou fruit
;

-- SOMA DE QUANTIDADE DE FRUTAS NO GERAL
SELECT 
	fruit, 
	SUM(quantity) AS quantidade_total_frutas
FROM fruit_inventory
GROUP BY fruit
;

-- VIZUALIZAR A QUANTIDADE DE FRUTAS POR MES
SELECT 
	fruit,
	STRFTIME('%m', arrival_date) AS month, -- No POSTGRESQL/SQL SERVER = DATE_TRUNC() e no MYSQL = DATE_FORMAT()
	SUM(quantity) AS quantidade_de_frutas
FROM 
	fruit_inventory
GROUP BY 
	month, fruit
;

-- VIZUALIZAR A QUANTIDADE DE FRUTAS POR MES (ESPECIFICANDO A FRUTA)
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