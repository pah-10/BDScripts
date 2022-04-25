/*AUTOJOINS*/
SELECT f.nome || ' ' || f.sobrenome || ' trabalha para ' || g.nome
FROM tb_funcionarios f, tb_funcionarios g
WHERE f.id_gerente = g.id_funcionario
ORDER BY f.nome;


/*

VERIFICAR sempre as ordens dos predicado durante a busca, para nao trazer problemas
de consistencia nos relatorios
O exemplo abaixo mostra isso ocorrendo, onde o relatŕoio sai com os dados invertidos
SELECT f.nome || ' ' || f.sobrenome || ' trabalha para ' || g.nome
FROM tb_funcionarios f, tb_funcionarios g
WHERE g.id_gerente = f.id_funcionario
ORDER BY f.nome;

*/


/*Junção externa que visa trazer os dados que o predicado da junção é falso*/
SELECT f.nome || ' trabalha para ' || NVL(g.sobrenome, 'os acionistas ')
FROM tb_funcionarios f, tb_funcionarios g
WHERE f.id_gerente = g.id_funcionario (+)
ORDER BY f.sobrenome DESC;

/*Sintaxe junção interna no padrão SQL/92*/
SELECT p.nm_produto AS PRODUTO, tp.nm_tipo_produto AS TIPO
FROM tb_produtos p
INNER JOIN tb_tipos_produtos tp ON (p.id_tipo_produto = tp.id_tipo_produto)
ORDER BY p.nm_produto;

/*NÂO-Equijoin com a clausula ON*/
SELECT f.nome, f.sobrenome, f.cargo, f.salario, gs.id_salario
FROM tb_funcionarios f
INNER JOIN tb_grades_salarios gs ON (f.salario BETWEEN gs.base_salario AND gs.teto_salario)
ORDER BY gs.id_salario;

/*Join com USING*/
SELECT p.nm_produto AS PRODUTO, tp.nm_tipo_produto AS TIPO
FROM tb_produtos p
INNER JOIN tb_tipos_produtos tp
USING (id_tipo_produto);

/* na clausula selec como na using não pode ser informado o identificador da tabela, e sim apenas o atributo*/
SELECT p.nm_produto AS PRODUTO, tp.nm_tipo_produto AS TIPO, id_tipo_produto
FROM tb_produtos p
INNER JOIN tb_tipos_produtos tp
USING (id_tipo_produto);


/*JOINs internas em mais de 2 tabelas usando SQL/92*/
SELECT c.nome, c.sobrenome, p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_clientes c
INNER JOIN tb_compras co USING (id_cliente)
INNER JOIN tb_produtos p USING (id_produto)
INNER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;

/*JOINS externas sintaxe SQL/92*/
/*LEFT OUTER JOIN*/
SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p
LEFT OUTER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;

/*RIGHT OUTER JOIN*/
SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p
RIGHT OUTER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;

/*FULL OUTER JOIN, preserva todas as tuplas das tabelas, mesmo que seja null*/
SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p
FULL OUTER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;


/*Auto Join*/
SELECT f.nome || ' ' || f.sobrenome || ' trabalha para ' || g.nome
FROM tb_funcionarios f
INNER JOIN tb_funcionarios g ON (f.id_gerente = g.id_funcionario)
ORDER BY f.nome;

/*JOIN Cruzada, CROSS JOIN é um produto cartesiano que só é utilizado quando há necessidade de melhoramento da perfomace do banco*/


/*Variaveis temporarias*/
SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto = &v_id_produto;

/*Atribuindo variaveis para coluno, nome de tabela e valor de coluna*/
SELECT nm_produto, &v_coluna
FROM &v_tabela
WHERE &v_coluna = &v_id_produto;

/* o && faz com que você informe o valor apenas uma vez*/
SELECT nm_produto, &&v_coluna
FROM &v_tabela
WHERE &&v_coluna = &v_id_produto;


/*VARIAVEIS DEFINIDAS, a linha do define deve ser executado antes*/
DEFINE v_id_produto = 7;

SELECT nm_produto, id_produto
FROM tb_produtos
WHERE id_produto = &v_id_produto;

/*VARIAVEIS DEFINIDAS USANDO ACCEPT*/
ACCEPT v_id NUMBER FORMAT 99 PROMPT 'Entre com o ID';

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto = &v_id;

/*Reomvendo variavel*/
DEFINE v_id_produto = 7;

SELECT nm_produto, id_produto
FROM tb_produtos
WHERE id_produto = &v_id_produto;

UNDEFINE v_id_produto;

/*GERANDO RELATORIOS SIMPLES*/

-- fazendo a chamada do script 1
@ \home\oracle\teste_1.sql

-- fazendo a chamada do script 2
@ \home\oracle\teste_2.sql

-- fazendo a chamada do script 3 já informando o valor da variavel
@ \home\oracle\teste_3.sql 7

-- fazendo a chamada do script 4 já informando o valor das variaveis separadas por espaço
@ \home\oracle\teste_4.sql 6 19.99


--Gerando instruções SQL automaticamente
SELECT 'DROP TABLE ' || table_name || ';'
FROM user_tables;

--EXE 1 Bloco anonimo

CREATE TABLE tb_teste(
ID      INTEGER,
valor   VARCHAR2(100));

--inicia o bloco anonimo
BEGIN

  FOR v_loop IN 1..100000 LOOP
    INSERT INTO tb_teste(ID, valor)
    VALUES (v_loop, 'DBA_' || v_loop);
  END LOOP;

END;

--seleciona todos os valores da tabela
SELECT *
FROM tb_teste
ORDER BY 1;

--remove todas as tuplas da tabela
TRUNCATE TABLE tb_teste;


-- EXE 2

CREATE TABLE tb_cliente_teste(
id_cliente  INTEGER,
ds_cliente  VARCHAR2(40),
nm_cliente  VARCHAR2(40),
valor       NUMERIC,
fg_ativo    INTEGER,
PRIMARY KEY(id_cliente)
);

SELECT *
FROM tb_cliente_teste;

--Inicio do procedure
CREATE OR REPLACE PROCEDURE manipula_dados(
  p_id_cliente IN tb_cliente_teste.id_cliente%TYPE,
  p_descricao IN tb_cliente_teste.ds_cliente%TYPE,
  p_nome IN tb_cliente_teste.nm_cliente%TYPE,
  p_valor IN tb_cliente_teste.valor%TYPE,
  p_fg_ativo IN tb_cliente_teste.fg_ativo%TYPE,
  p_opcao IN CHAR)

AS
v_controle INTEGER;

BEGIN

--verifica se existe ou não tuplas na tb_cliente_Teste
SELECT COUNT(*) INTO v_controle
FROM tb_cliente_teste
WHERE id_cliente = p_id_cliente
AND fg_ativo = 1;

--opcao = I (insert)
IF(p_opcao = 'I')THEN
  IF(v_controle != 1) THEN
    INSERT INTO tb_cliente_teste(id_cliente, ds_cliente, nm_cliente, valor, fg_ativo)
    VALUES(p_id_cliente, p_descricao, p_nome, p_valor, p_fg_ativo);
    COMMIT;
    dbms_output.put_line('Cliente inserido com sucesso');
    
  ELSE
    dbms_output.put_line('ID do cliente já existente');
  END IF;
END IF;

--opçao = U (update)
IF (p_opcao = 'U') THEN
  IF (v_controle = 1) THEN
    UPDATE tb_cliente_teste SET ds_cliente = p_descricao, nm_cliente = p_nome, valor = p_valor, fg_ativo = p_fg_ativo
    WHERE id_cliente = p_id_cliente
    AND fg_ativo = 1;
    
    COMMIT;
    dbms_output.put_line('Cliente alterado com sucesso');
  ELSE
    dbms_output.put_line('ID do cliente não existe');
  END IF;
END IF;

--opçao = D (delete)
IF(p_opcao = 'D') THEN
  IF(v_controle = 1) THEN
    DELETE
    FROM tb_cliente_teste
    WHERE id_cliente = p_id_cliente
    AND fg_ativo = 1;
    
    COMMIT;
    dbms_output.put_line('Cliente excluído com sucesso');
  
  ELSE
    dbms_output.put_line('ID de cliente não existente');
  END IF;
END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;                    
END manipula_dados;


-- Inserindo dados por bloco anonimo

SET serveroutput ON
BEGIN
  --insert de tuplas
  --manipula_dados(1, 'Cliente 1', 'Nome do Cliente 1', 22.33, 1, 'I');
  --manipula_dados(2, 'Cliente 2', 'Nome do Cliente 2', 99.99, 1, 'I');
  
  --update de tuplas
  --manipula_dados(1, 'Cliente alterado hoje', 'Alterado', 99.99, 1, 'U');
  
  --excluisao de tuplas
  manipula_dados(1, NULL, NULL, NULL, NULL, 'D');

END;

/*Inserindo dados manualmente pelo call

--insert
CALL manipula_dados(1, 'Cliente 1', 'Nome do Cliente 1', 22.33, 1, 'I');
CALL manipula_dados(1, 'Cliente 1', 'Nome do Cliente 1', 22.33, 1, 'I');

--update
  manipula_dados(1, 'Cliente alterado hoje', 'Alterado', 99.99, 1, 'U');

--delete
manipula_dados(1, NULL, NULL, NULL, NULL, 'D');
*/

SELECT *
FROM tb_cliente_teste;
