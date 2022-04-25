SELECT id_tipo_produto, VARIANCE(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

SELECT VARIANCE(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY VARIANCE(preco);

/*FUNÇÔES AGREGADAS PRECISAM USAR O GROUP BY QUANDO USADAS COM OUTROS ATRIBUTOS
  
  Assim da erro:
  SELECT id_tipo_produto, AVG(preco)
  FROM tb_produtos;
  
  Sozinho funciona:
  SELECT AVG(preco)
  FROM tb_produtos;
  
  NÃO PODE LIMITAR CLAUSAS WHERE LIMITADAS POR FUNÇÕES AGRAGADAS, PODE COLOCA-LAS NO HAVING
*/

/*NÃO PODE LIMITAR CLAUSAS WHERE LIMITADAS POR FUNÇÕES AGRAGADAS, PODE COLOCA-LAS NO HAVING
  
  Assim da erro:
  SELECT id_tipo_produto, AVG(preco)
  FROM tb_produtos
  WHERE AVG(PRECO) > 20.00
  GROUP BY id_tipo_produto;
  
  Com o limite no having funciona:
  SELECT id_tipo_produto, AVG(preco)
  FROM tb_produtos
  GROUP BY id_tipo_produto
  HAVING AVG(PRECO) > 20.00;
*/

SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(PRECO) > 20.00;

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


INSERT INTO tb_clientes (id_cliente, nome, sobrenome, dt_nascimento, telefone, fg_ativo)
VALUES (7,'Steve','Purple', DATE'1972-10-25','800-555-1215',1);

SELECT *
FROM tb_clientes;

SELECT id_cliente, TO_CHAR(dt_nascimento, 'MONTH DD, YYYY')
FROM tb_clientes;

SELECT TO_CHAR(SYSDATE, 'MONTH DD, YYYY, HH24:MI:SS')
FROM dual;

SELECT TO_CHAR(TO_DATE('05-FEB-1968'), 'MONTH DD, YYYY')
FROM dual;

SELECT TO_DATE('04-JUL-2013'), TO_DATE('04-JUL-13')
FROM dual;

/*SELECIONA para verificar todos os parametro que podem ser alteradas ao nível de sessão, ou seja,
quando fechar vai voltar ao normal

SELECT *
FROM nls_session_parameters;


ALTERA o formato dos parametro do formato da date para a sessão

ALTER SESSION SET NLS_DATE_FORMAT = 'Mon/dd/yyyy';
*/

SELECT TO_DATE('Jul 04, 2013', 'MONTH DD, YYYY')
FROM dual;

SELECT TO_DATE('7.4.13', 'MM.DD.YY')
FROM dual;

/*UTILIZAR TO_CHAR PARA FAZER ALTERACAO DAS DATAS EM PROVAS*/

INSERT INTO tb_clientes(id_cliente, nome, sobrenome, dt_nascimento, telefone, fg_ativo)
VALUES (10,'Nome', 'Sobrenome', TO_DATE('Jul 04, 2013 19:32:36', 'MONTH DD, YYYY HH24:MI:SS'),'800-555-1215',1);

SELECT *
FROM tb_clientes;

SELECT id_cliente, TO_CHAR(dt_nascimento, 'DD-MON-YYYY HH24:MI:SS')
FROM tb_clientes
ORDER BY id_cliente;

ROLLBACK;


SELECT TO_CHAR(TO_DATE('Jul 04, 2013 19:32:36', 'MONTH DD, YYYY HH24:MI:SS'), 'HH24:MI:SS')
FROM dual;

SELECT 
  TO_CHAR(TO_DATE('Jul 04,15','MONTH DD, YY'), 'MONTH DD, YYYY'),
  TO_CHAR(TO_DATE('Jul 04,75','MONTH DD, YY'), 'MONTH DD, YYYY')
FROM dual;

SELECT 
  TO_CHAR(TO_DATE('Jul 04,15','MONTH DD, RR'), 'MONTH DD, YYYY'),
  TO_CHAR(TO_DATE('Jul 04,75','MONTH DD, RR'), 'MONTH DD, YYYY')
FROM dual;

/*FUNÇÔES DE DATA E HORA*/

--soma
SELECT ADD_MONTHS('Jul 01, 2013', 13)
FROM dual;

--subtrai
SELECT ADD_MONTHS('Jul 01, 2013', -13)
FROM dual;

--retorna a data do ultimo dia do mes
SELECT LAST_DAY('Jul 01, 2013')
FROM dual;

--retorna a data do ultimo dia do mes
SELECT LAST_DAY('Aug 07, 2002')
FROM dual;

--retorna a qtd de meses existente entre duas datas
SELECT MONTHS_BETWEEN('Jul 03, 2013','May 01, 2011')
FROM dual;

SELECT MONTHS_BETWEEN('Apr 25, 2022', 'Aug 07, 2002')
FROM dual;

--retorna a data do proximo dia depois de algo
SELECT NEXT_DAY('Jul 03, 2013', 1)
FROM dual;

SELECT NEXT_DAY('Apr 25, 2022', 1)
FROM dual;

--arredonda a data para um inicio mais proximo
SELECT ROUND(TO_DATE('Jul 03, 2013'), 'YYYY')
FROM dual;

SELECT ROUND(TO_DATE('Jun 03, 2013'), 'YYYY')
FROM dual;

SELECT ROUND(TO_DATE('Jul 03, 2013'), 'MM')
FROM dual;

SELECT ROUND(TO_DATE('Jul 20, 2013'), 'MM')
FROM dual;

SELECT TO_CHAR(ROUND(TO_DATE('Jul 03, 2013 19:45:26', 'MONTH DD,YYYY HH24:MI:SS'),'HH24'),'MONTH DD, YYYY HH24:MI:SS')
FROM dual;

SELECT SYSDATE
FROM dual;

/*Função bastante utilizada no mercado, é padrão ANSI, pode ser usada em hora e data*/
SELECT
  EXTRACT(YEAR FROM TO_DATE('Jul 03,2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS YEAR,
  EXTRACT(MONTH FROM TO_DATE('Jul 03,2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS MONTH,
  EXTRACT(DAY FROM TO_DATE('Jul 03,2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS DAY
FROM dual;

SELECT
  EXTRACT(HOUR FROM TO_TIMESTAMP('Jul 03,2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS HOUR,
  EXTRACT(MINUTE FROM TO_TIMESTAMP('Jul 03,2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS MINUTE,
  EXTRACT(SECOND FROM TO_TIMESTAMP('Jul 03,2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS SECOND
FROM dual;
