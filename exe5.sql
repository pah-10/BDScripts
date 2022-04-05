--Criação das tabelas
CREATE TABLE mulher(
id_mulher NUMBER CONSTRAINT m_id_mulher NOT NULL,
nome_mulher VARCHAR2(40),

CONSTRAINT pk_id_mulher PRIMARY KEY(id_mulher)
);

SELECT *
FROM mulher;

CREATE TABLE homem(
id_homem NUMBER CONSTRAINT m_id_homem NOT NULL,
nome_homem VARCHAR2(40),
id_mulher NUMBER,

CONSTRAINT pk_id_homem PRIMARY KEY(id_homem),
CONSTRAINT fk_id_mulher FOREIGN KEY(id_mulher) REFERENCES mulher(id_mulher)
);

CREATE SEQUENCE home
START WITH      10
INCREMENT BY    10
MAXVALUE        9900
NOCACHE
NOCYCLE;

SELECT *
FROM homem;


--Inserindo dados nas tabelas exe 1 e 2

INSERT INTO mulher
VALUES (1,'Edna');

INSERT INTO mulher
VALUES (2, 'Stefanny');

INSERT INTO mulher
VALUES (3, 'Cássia');

SELECT *
FROM mulher;

INSERT INTO homem
VALUES (10, 'Anderson', NULL);

INSERT INTO homem
VALUES (20, 'Jander', 1);

INSERT INTO homem
VALUES (30, 'Rogério', 2);

SELECT *
FROM homem;
--------------------------------------
--Fazendo os joins
--------------------------------------


--Seleção dos casamentos exe 3

/*
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS Casamento
FROM homem h, mulher m 
WHERE h.id_mulher = m.id_mulher;
*/

--3 a 
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS Casamento
FROM homem h
INNER JOIN mulher m ON h.id_mulher = m.id_mulher
ORDER BY h.nome_homem;

-- 3 b - Natural JOIN

SELECT *
FROM homem
NATURAL JOIN mulher;

SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS Casamento
FROM homem h
NATURAL JOIN mulher m;

--Exe 3 c - JOIN com USING (especializa ambas as tabelas)
SELECT nome_homem, nome_mulher
FROM homem
INNER JOIN mulher USING (id_mulher);

--3 d - JOIN com ON
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS Casamento
FROM homem h
INNER JOIN mulher m ON h.id_mulher = m.id_mulher
ORDER BY h.nome_homem;

--3 e - CROSS JOIN
SELECT nome_homem, nome_mulher
FROM homem
CROSS JOIN mulher
ORDER BY nome_homem;

SELECT nome_homem, nome_mulher
FROM homem, mulher
ORDER BY nome_homem;

--4 OUTER JOINS
