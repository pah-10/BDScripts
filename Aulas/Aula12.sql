-- Segunda Parte Banco de Dados

-- GROUP BY
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

SELECT id_tipo_produto, ROUND(VARIANCE(preco), 2)
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

SELECT ROUND(VARIANCE(preco), 2)
FROM tb_produtos
GROUP BY (id_tipo_produto)
ORDER BY VARIANCE(preco);

-- Importante
-- Erro pela falta do Group By
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos;

SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
WHERE AVG(preco) > 20.00
GROUP BY id_tipo_produto;

-- GROUP BY pode ser usado com HAVING, porém o contrário NÃO ocorre.
-- Exemplo
SELECT id_tipo_produto, ROUND(AVG(preco), 2)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) > 20.00;

SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
WHERE preco < 15.00
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
WHERE preco < 15.00
GROUP BY id_tipo_produto
HAVING AVG(preco) > 13.00
ORDER BY id_tipo_produto;

INSERT INTO tb_clientes (id_cliente, nome, sobrenome, dt_nascimento, 
                        telefone, fg_ativo)
VALUES (7, 'Steve', 'Purple', DATE '1972-10-25', '800-555-1215', 1);

SELECT *
FROM tb_clientes
ORDER BY id_cliente;

SELECT id_cliente, TO_CHAR(dt_nascimento, 'MONTH DD, YYYY') AS "Data de Nascimento"
FROM tb_clientes;

SELECT TO_CHAR(SYSDATE, 'MONTH DD, YYYY, HH24:MI:SS') AS "Data e Hora Atual"
FROM dual;

SELECT TO_CHAR(TO_DATE('05-FEB-1968'), 'MONTH DD, YYYY') AS "Convertendo Data para String"
FROM dual;

SELECT TO_DATE('04-JUL-2013'), TO_DATE('04-JUL-13')
FROM dual;

-- Formatando com NLS Parameters
SELECT TO_DATE('Jul 04, 2013', 'MONTH DD, YYYY')
FROM dual;

SELECT *
FROM nls_session_parameters;

ALTER SESSION SET NLS_DATE_FORMAT = 'MON/DD/YYYY';


SELECT TO_DATE('7.4.13', 'MM.DD.YY')
FROM dual;

-- TO_CHAR para Manipulação Flexível

------------------------------------------------------------
-- Especificar Data e Hora
INSERT INTO tb_clientes (id_cliente, nome, sobrenome, dt_nascimento,
                         telefone, fg_ativo)
VALUES (10, 'Nome', 'Sobrenome', TO_DATE('Jul 04, 2013 19:32:36', 'MONTH DD, YYYY HH24:MI:SS'), '800-555-1215', 1);

SELECT id_cliente, TO_CHAR(dt_nascimento, 'DD-MON-YYYY HH24:MI:SS')
FROM tb_clientes
ORDER BY id_cliente;

ROLLBACK;

-- Mesclando TO_CHAR e TO_DATE
SELECT TO_CHAR(TO_DATE('Jul 04, 2013 19:32:36', 'MONTH DD YYYY HH24:MI:SS'), 'HH24:MI:SS')
FROM dual;

-- Dois Dígitos para o Year
SELECT
  TO_CHAR(TO_DATE('Jul 04, 15', 'MONTH DD YY'), 'MONTH DD, YYYY'),
  TO_CHAR(TO_DATE('Jul 04, 75', 'MONTH DD YY'), 'MONTH DD, YYYY')
FROM dual;

SELECT
  TO_CHAR(TO_DATE('Jul 04, 15', 'MONTH DD RR'), 'MONTH DD, YYYY'),
  TO_CHAR(TO_DATE('Jul 04, 75', 'MONTH DD RR'), 'MONTH DD, YYYY')
FROM dual;



----- Funções de Data/Hora
-- ADD_MONTHS(x, y)
-- Retorna a Adição de Y sobre X
-- Se o Y for Negativo, Y meses serão subtraídos de X
SELECT ADD_MONTHS('Jul 01, 2013', 13)
FROM Dual;

SELECT ADD_MONTHS('Jul 01, 2013', -13)
FROM Dual;

-- LAST_DAY(x)
-- Retorna a Data do Último Dia a partir de X referente ào Mês
SELECT LAST_DAY('Jul 01, 2013')
FROM dual;

-- MONTHS_BETWEEN(x, y)
-- Retorna o Número de Meses entre X e Y
-- Se o X ocorre antes de Y no Calendário, a Função retorna Negativo
SELECT MONTHS_BETWEEN('Jul 01, 2013', 'May 01, 2011')
FROM dual;

-- NEXT_DAY(x, Dia)
-- Retorna a Data do Próximo Dia depois de X
-- Sunday = 1, Monday = 2, Tuesday = 3
SELECT NEXT_DAY('Apr 25, 2022', 1)
FROM dual;

-- ROUND (x, [Unidade])
-- Arredonda X por Padrão
SELECT ROUND(TO_DATE('Jul 03, 2013'), 'YYYY')
FROM dual;

SELECT ROUND(TO_DATE('Jan 03, 2013'), 'YYYY')
FROM dual;

SELECT ROUND(TO_DATE('May 25, 2013'), 'MM')
FROM dual;

SELECT ROUND(TO_DATE('May 10, 2013'), 'MM')
FROM dual;

SELECT
  TO_CHAR(ROUND(TO_DATE('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS'), 'HH24'), 'MONTH DD, YYYY HH24:MI:SS')
FROM dual;

-- SYSDATE
SELECT SYSDATE
FROM dual;

-- EXTRACT(x)
-- Padrão SQL/ANSI
-- Extrai e Retorna o Ano, Mês, Dia, Hora, Minuto, Segundo ou Fuso Horário de X
-- X pode ser um TIMESTAMP
SELECT
  EXTRACT(YEAR FROM TO_DATE('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS YEAR,
  EXTRACT(MONTH FROM TO_DATE('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS MONTH,
  EXTRACT(DAY FROM TO_DATE('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS DAY
FROM dual;

SELECT
  EXTRACT(HOUR FROM TO_TIMESTAMP('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS HORA,
  EXTRACT(MINUTE FROM TO_TIMESTAMP('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS MINUTO,
  EXTRACT(SECOND FROM TO_TIMESTAMP('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS SEGUNDO
FROM dual;

----- Funções de Intervalos de Tempo
-- NUMTODSINTERVAL
SELECT
  NUMTODSINTERVAL(1.5, 'DAY'),
  NUMTODSINTERVAL(3.25, 'HOUR'),
  NUMTODSINTERVAL(5, 'MINUTE'),
  NUMTODSINTERVAL(10.123456789, 'SECOND')
FROM dual;

-- NUMTOYMINTERVAL
SELECT
  NUMTOYMINTERVAL(1.5, 'YEAR'),
  NUMTOYMINTERVAL(3.25, 'MONTH')
FROM dual;

----- Subquery
-- Uma Linha
-- Subconsultas de uma linha podem retornar no máximo uma linha
-- WHERE, HAVING, FROM
SELECT nome, sobrenome
FROM tb_clientes
WHERE id_cliente = (SELECT id_cliente
                    FROM tb_clientes
                    WHERE sobrenome = 'Blue');
                    
SELECT id_cliente
FROM tb_clientes
WHERE sobrenome = 'Blue';


SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos);
               
SELECT AVG(preco)
FROM tb_produtos;


SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) < (SELECT MAX(AVG(preco))
                     FROM tb_produtos
                     GROUP BY id_tipo_produto)
ORDER BY id_tipo_produto;

SELECT MAX(AVG(preco))
FROM tb_produtos
GROUP BY id_tipo_produto;

-- FROM
SELECT id_produto
FROM (SELECT id_produto
      FROM tb_produtos
      WHERE id_produto < 3);
      
SELECT id_produto
FROM tb_produtos
WHERE id_produto < 3;


SELECT p.id_produto, preco, dados_compra.count_produto
FROM tb_produtos p, (SELECT id_produto, COUNT(id_produto) count_produto
                     FROM tb_compras
                     GROUP BY id_produto) dados_compra
WHERE p.id_produto = dados_compra.id_produto;

SELECT id_produto, COUNT(id_produto)
FROM tb_compras
GROUP BY(id_produto);

-- Duas ou Mais Linhas
-- IN, ANY, ALL
SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto IN (1,2,3);

-- IN + NOT é PERMITIDO
SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto IN (SELECT id_produto
                     FROM tb_produtos
                     WHERE nm_produto LIKE '%e%');
                     
SELECT id_produto
FROM tb_produtos
WHERE nm_produto LIKE '%e%';


SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto NOT IN (SELECT id_produto
                         FROM tb_compras);
                         
-- ANY
SELECT id_funcionario, nome, salario
FROM tb_funcionarios
WHERE salario < ANY (SELECT base_salario
                     FROM tb_grades_salarios);
                     
-- ALL
SELECT id_funcionario, nome, salario
FROM tb_funcionarios
WHERE salario > ALL (SELECT base_salario
                     FROM tb_grades_salarios);
                     

SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos
WHERE (id_tipo_produto, preco) IN (SELECT id_tipo_produto, MIN(preco)
                                   FROM tb_produtos
                                   GROUP BY id_tipo_produto);
                                   
SELECT id_tipo_produto, MIN(preco)
FROM tb_produtos
GROUP BY id_tipo_produto;

-- Não Correlacionada = A Query isolada NÃO é Dependente da Externa 
-- Correlacionada = A Query isolada é Dependente da Externa

------ Subconsultas Correlacionadas
-- São Relacionadas à Instrução SQL Externa por meio das Mesmas Colunas
SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos externa
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos interna
               WHERE interna.id_tipo_produto = externa.id_tipo_produto);
               
-- EXISTS e NOT EXISTS
-- EXISTS Verifica a Existência de Linhas Retornadas pela Subconsulta
-- EXISTS pode ser Usado em Subconsultas Não Correlacionadas, ele é Utilizado
-- por Subconsultas Correlacionadas
-- Ganho Performático
SELECT id_funcionario, nome, sobrenome
FROM tb_funcionarios externa
WHERE EXISTS (SELECT id_funcionario
              FROM tb_funcionarios interna
              WHERE interna.id_gerente = externa.id_funcionario);
              
SELECT id_funcionario, nome, sobrenome
FROM tb_funcionarios externa
WHERE EXISTS (SELECT 1
              FROM tb_funcionarios interna
              WHERE interna.id_gerente = externa.id_funcionario);
              
-- NOT EXISTS
SELECT id_produto, nm_produto
FROM tb_produtos externa
WHERE NOT EXISTS (SELECT 1
                  FROM tb_compras interna
                  WHERE interna.id_produto = externa.id_produto);
                  

-- EXISTS Verifica apenas a EXISTÊNCIA
-- IN Verifica uma LISTA de VALORES

-- Quando a Lista de Valores for
SELECT id_tipo_produto, nm_tipo_produto
FROM tb_tipos_produtos externa
WHERE NOT EXISTS (SELECT 1
                  FROM tb_produtos interna
                  WHERE interna.id_tipo_produto = externa.id_tipo_produto);
                  
-- Uso de NVL para Solucionar NOT IN
SELECT id_tipo_produto, nm_tipo_produto
FROM tb_tipos_produtos
WHERE id_tipo_produto NOT IN (SELECT NVL(id_tipo_produto, 0)
                              FROM tb_produtos);

---- Subconsultas Aninhadas
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) < (SELECT MAX(AVG(preco))
                     FROM tb_produtos
                     WHERE id_produto IN (SELECT id_produto
                                          FROM tb_compras
                                          WHERE quantidade > 1)
                     GROUP BY id_tipo_produto)
ORDER BY id_tipo_produto;

---- UPDATE e DELETE
UPDATE tb_funcionarios
SET salario = (SELECT AVG(teto_salario)
               FROM tb_grades_salarios)
WHERE id_funcionario = 4;

ROLLBACK;

DELETE
FROM tb_funcionarios
WHERE salario > (SELECT AVG(teto_salario)
                 FROM tb_grades_salarios)

ROLLBACK;
