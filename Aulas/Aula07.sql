--Faz a mudança do resultado da query apenas na plotação, não muda o dado como o update
SELECT REPLACE (nm_produto, 'Science', 'Physics')
FROM tb_produtos
WHERE id_produto = 1;

--TRAz ums string que contem a representacao fonetica de algo, mas em ingles
SELECT sobrenome
FROM tb_clientes
WHERE SOUNDEX(sobrenome) = SOUNDEX('whyte');

--Obetem a qtd de string que seja necessário voce desejar, é posivel ou não, definir um comprimento maximo do sobstring 
SELECT nm_produto, SUBSTR(nm_produto, 2, 7)
FROM tb_produtos
WHERE id_produto < 4;

--é possivel usar na tabela defult para strair de um valor string qualquer
SELECT SUBSTR('Administrador de Banco de Dados - DBA', 34, 4)
FROM dual;


--REALIZANDO A MESCLAGEM DE FUNÇOES

--Função UPPER com SUBSTR
SELECT nm_produto, UPPER(SUBSTR(nm_produto, 2, 8))
FROM tb_produtos
WHERE id_produto < 4;

--Retorna o valor absoluto de um numero, ou seja o numero sem sinal de positivo e negativo
SELECT id_produto, preco, preco - 30.00, ABS(preco - 30.00)
FROM tb_produtos
WHERE id_produto < 4;

-- Realiza o arredondamento de um valor para cima
SELECT CEIL(5.8), CEIL(-5.2)
FROM dual;

-- Realiza o arrendamento de um valor para baixo
SELECT FLOOR(5.8), FLOOR(-5.8)
FROM dual;

--Pega o resto da divisao, exe divide 8 por 3 e 8 por 4
SELECT MOD(8,3), MOD(8,4)
FROM dual;

-- PEga o resultdado da potenciacao de, exe, 2 a 1 e 2 a 3
SELECT POWER (2,1), POWER(2,3)
FROM dual;

-- Forma de arredondamento que realmente é utilizada
--O arredondamento negativo a esquerda não é muito utilizado pois muda o valor
SELECT ROUND(5.75), ROUND(5.75,1), ROUND(5.75, -1)
FROM dual;

--Obtem o valor do sinal de um numero
SELECT SIGN(-5), SIGN(5), SIGN(0)
FROM dual;

--Obtem a raiz quadrada de um numero
SELECT SQRT(25), SQRT(5)
FROM dual;

-- Faz a desconsideracao/truncamento de valores
--nao existe o habito de realizar o trancamento negativo ou a esquerda pois altera o valor
SELECT TRUNC(5.75), TRUNC(5.75, 1), TRUNC(5.75, -1)
FROM dual;

--Funções de conversao

--converte numero para string
SELECT to_CHAR(12345.67)
FROM dual;

--converte numero para string com formato de formatação
SELECT TO_CHAR(12345.67, '99,999.99')
FROM dual;

SELECT TO_CHAR(12345.67, '$99,999.99')
FROM dual;

-- Parametro B retorna espacos no lugar de zero 0
SELECT TO_CHAR(00.67, 'B9.99')
FROM dual;

--parametro C retorna o simbolo monetario correndo do SGBD
SELECT TO_CHAR(12345.67, 'C99,999.99')
FROM dual;

-- retorna com uma notação cientifica
SELECT TO_CHAR(12345.67, '99999.99EEEE')
FROM dual;

--retorna sem espaços no fim ou no inicio, considera 0 como espaço
SELECT TO_CHAR(0012345.6700, 'FM99999.99')
FROM dual;

SELECT TO_CHAR(  12345.670  , 'FM99999.99')
FROM dual;

--retorna o simbolo da moeda local, mesmo se o SGBD estiver com ingles
SELECT TO_CHAR(12345.67, 'L99,999.99')
FROM dual;

--retorna um numero negativo com um sinal - a direita
SELECT TO_CHAR(-12345.67, '99,999.99MI')
FROM dual;

--retorna um numero positivo com o espaço a direita
SELECT TO_CHAR(12345.67, '99,999.99MI')
FROM dual;

--envolve o numero entre os sinais <>
SELECT TO_CHAR(-12345.67, '99,999.99PR')
FROM dual;

--retorna os numeros em algoritmos romanos
SELECT TO_CHAR(2022, 'RN')
FROM dual;

SELECT TO_CHAR(2022, 'rn')
FROM dual;

--retorna o sinal do numro que foi convertido com o sinal a esquerda + ou -
SELECT TO_CHAR(12345.67, 'S99999.99'), TO_CHAR(-12345.67, 'S99999.99')
FROM dual;

--retorna o simbolo da moeda em um local desejado
SELECT TO_CHAR(12345.67, 'U99,999.99')
FROM dual;

--retorna o numero multiplicado por 10 vezes o numero
SELECT TO_CHAR(12345.67, '99999V99')
FROM dual;

-- convert colunas contendo numeros em expressoes literais da coluna
SELECT id_produto, 'O preço do produto é: ' || TO_CHAR(preco, 'L99.99')
FROM tb_produtos
WHERE id_produto < 5;

-- convertendo string em números

SELECT TO_NUMBER('970.13')
FROM dual;

--apos a conversao é possivel realizar operações matematicas com o novo numero
SELECT TO_NUMBER ('970.13') + 25.50
FROM dual;

--fornece um formato para um numero
SELECT TO_NUMBER('-$12,345.67', '$99,999.99')
FROM dual;

--Converte valores literais em tipos especificos
SELECT
  CAST (12345.67 AS VARCHAR2(10)),
  CAST ('9A4F' AS RAW(2)),
  CAST ('01-DEC-2007' AS DATE),
  CAST (12345.678 AS NUMBER(10,2))
FROM dual;

SELECT
  CAST(preco AS VARCHAR2(10)),
  CAST(preco + 2 AS NUMBER(7,2)),
  CAST(preco AS BINARY_DOUBLE)
FROM tb_produtos
WHERE id_produto = 1;

-- a utilização de expressoes regulares é considerado algo intermediário e super valorizado
-- exemplo 196[5-8]$ ou ^196[5-8]$
SELECT id_cliente, nome, sobrenome, dt_nascimento
FROM tb_clientes
WHERE REGEXP_LIKE(TO_CHAR(dt_nascimento, 'YYYY'), '196[5-8]$');

-- recupera sem utilizar o sensitive case
SELECT id_cliente, nome, sobrenome, dt_nascimento
FROM tb_clientes
WHERE REGEXP_LIKE(nome, 'j', 'i');
