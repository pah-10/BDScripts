SELECT nm_produto, preco, preco + 2.00
FROM tb_produtos;

/*TABELAS DUAL*/

DESCRIBE dual;

SELECT *
from dual;


/*CRIANDO nomes alternativos na tabela*/

SELECT preco, preco * 2 DOBRO_PREÇO
FROM tb_produtos;

SELECT preco, preco * 2 "Dobro do Preço"
FROM tb_produtos;

select PRECO, PRECO * 2 AS "Dobro do Preço"
FROM tb_produtos;


/*CONCATENACAO ||*/
SELECT nome || ' ' || sobrenome AS "Nome do Cliente"
from tb_clientes;

SELECT 'O nome completo do cliente eh ' || nome || ' ' || sobrenome || ' e sua data de nascimento eh ' || dt_nascimento as "Mensagem"
FROM tb_clientes;


/* Valores nulos */
SELECT *
FROM tb_empregado;

SELECT id_cliente, nome, sobrenome, dt_nascimento
FROM tb_clientes
WHERE dt_nascimento IS NULL;

SELECT id_cliente, nome, sobrenome, telefone
FROM tb_clientes
WHERE telefone IS NULL;

/* função NVL retorno outro valor quando o parametro é nulo e não apenas um espaço em branco */
SELECT id_cliente, nome, sobrenome, 
NVL(telefone, 'Número do telefone desconhecido') AS Número_Telefone
FROM tb_clientes;

SELECT id_cliente, nome, sobrenome, 
NVL(dt_nascimento, '22/JUN/2013') AS "Data de Nascimento"
FROM tb_clientes;

/* A função NULLIF realiza a comparação entre duas expressoes, 
retornando NULL quando é equivalente e a primeira expressao caso não seja*/
SELECT nome, LENGTH(nome) "expressão 1",
  sobrenome, LENGTH(sobrenome) "expressão 2",
  NULLIF(LENGTH(nome), LENGTH(sobrenome)) "Resultado"
FROM tb_funcionarios;

/*verificar slide 57*/
SELECT sobrenome, id_empregado, percentual_comissao, id_gerente,
  COALESCE(TO_CHAR(percentual_comissao),
          TO_CHAR(id_gerente),
          'Nenhuma comissão e nenhum gerente')
FROM tb_funcionario;

SELECT *
FROM tb_clientes
WHERE id_cliente <> 2;

SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto > 2;

SELECT ROWNUM, id_produto, nm_produto
FROM tb_produtos
WHERE ROWNUM <= 3;

SELECT *
FROM tb_clientes
WHERE id_cliente > ANY (2, 3, 4);

SELECT *
FROM tb_clientes
WHERE id_cliente > ALL (2, 3, 4);


/* Operadores SQL*/
SELECT *
FROM tb_clientes
WHERE nome LIKE '_o%';

SELECT *
FROM tb_clientes
WHERE nome LIKE '_a%';

SELECT *
FROM tb_clientes
WHERE nome LIKE '____';

SELECT *
FROM tb_clientes
WHERE nome LIKE 'J%';

SELECT nome
FROM tb_promocao
WHERE nome LIKE '%\%%' ESCAPE '\';

SELECT nome
FROM tb_promocao
WHERE nome LIKE '%*%%' ESCAPE '*';


/*OPERADOR IN*/
SELECT *
FROM tb_clientes
WHERE id_cliente IN (2, 3, 5);

SELECT *
FROM tb_clientes
WHERE id_cliente NOT IN (2, 3, 5);

/* retorna consulta falsa pois a lista de valores possui o NULL*/
SELECT *
FROM tb_clientes
WHERE id_cliente NOT IN (2, 3, 5, NULL);

/*Operador beetwaen*/
SELECT *
FROM tb_clientes
WHERE id_cliente BETWEEN 1 AND 3;

SELECT *
FROM tb_clientes
WHERE id_cliente NOT BETWEEN 1 AND 3;

/* OPERADOR LOGICO AND*/
SELECT *
FROM tb_clientes
WHERE dt_nascimento > '01/JAN/1970' AND id_cliente > 3;

SELECT *
FROM tb_clientes
WHERE dt_nascimento > '01/JAN/1970' OR id_cliente > 3;

/*verificar slide 92*/

SELECT *
FROM tb_clientes
WHERE dt_nascimento > '01/JAN/1970' OR id_cliente < 2 AND telefone LIKE '%1211';

/*OREDENACAO */

SELECT * 
FROM tb_clientes
ORDER BY sobrenome;


/*quando ha impactos entre a primeira ordenação*/
SELECT *
FROM tb_clientes
ORDER BY nome ASC, sobrenome DESC;

/*POR ORDEM DE ATRIBUTOS, no caso o 1º que é o di_cliente*/
SELECT id_cliente, nome, sobrenome
FROM tb_clientes
ORDER BY 1;

SELECT id_cliente, nome, sobrenome
FROM tb_clientes
ORDER BY 3;

/* quando é usado o * é respeitado a ordem da criação/definição dos atributos da tabela */
SELECT *
FROM tb_clientes
ORDER BY 3;


      /* nm produto e id do tipo do produto*/
SELECT nm_produto, id_tipo_produto
FROM tb_produtos
WHERE id_produto = 3;

SELECT nm_tipo_produto
FROM tb_tipos_produtos
WHERE id_tipo_produto = 2;

SELECT tb_produtos.nm_produto, tb_tipos_produtos.nm_tipo_produto
FROM tb_produtos, tb_tipos_produtos
WHERE tb_produtos.id_tipo_produto = tb_tipos_produtos.id_tipo_produto AND tb_produtos.id_produto = 3;


/* nm produto e id do tipo do produto ordenados pelo nm_produto*/
SELECT tb_produtos.nm_produto, tb_tipos_produtos.nm_tipo_produto
FROM tb_produtos, tb_tipos_produtos
WHERE tb_produtos.id_tipo_produto = tb_tipos_produtos.id_tipo_produto
ORDER BY tb_produtos.nm_produto;


/*CRIANDO APELIDOS PARA AS TABELAS*/
SELECT p.nm_produto, tp.nm_tipo_produto
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto = tp.id_tipo_produto
ORDER BY p.nm_produto;

/*a ausencia do JOIN gera o Produto cartesiano*/
SELECT p.nm_produto, tp.nm_tipo_produto
FROM tb_produtos p, tb_tipos_produtos tp;

SELECT c.nome, c.sobrenome, p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_clientes c, tb_compras co, tb_produtos p, tb_tipos_produtos tp
WHERE c.id_cliente = co.id_cliente AND p.id_produto = co.id_produto AND p.id_tipo_produto = tp.id_tipo_produto
ORDER BY p.nm_produto;

/* Não-equijoins*/

SELECT *
FROM tb_grades_salarios;

SELECT f.nome, f.sobrenome, f.cargo, f.salario, gs.id_salario
FROM tb_funcionarios f, tb_grades_salarios gs
WHERE f.salario BETWEEN gs.base_salario AND gs.teto_salario
ORDER BY gs.id_salario;

/* join externa esquerda*/
SELECT p.nm_produto AS produto, tp.nm_tipo_produto tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto = tp.id_tipo_produto (+)
ORDER BY 1;

/* join externa direita*/
SELECT p.nm_produto AS produto, tp.nm_tipo_produto tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto (+) = tp.id_tipo_produto
ORDER BY 1;


/* join externa direita com OR não pode ser feita, da erro*/
SELECT p.nm_produto AS produto, tp.nm_tipo_produto tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto (+) = tp.id_tipo_produto
OR p.id_tipo_produto = 1;

commit;
