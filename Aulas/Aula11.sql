/*
Subconsultas de uma única linha retornam zero ou no máximo 1 linha
Pode ser usada no where, having ou no from
Não podem ser ordenadas
*/

SELECT id_cliente, nome, sobrenome
FROM tb_clientes
WHERE id_cliente = (SELECT id_cliente
                    FROM tb_clientes
                    WHERE sobrenome = 'Blue');
                    
SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos)
ORDER BY id_produto DESC;

SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) < (SELECT MAX(AVG(preco))
                     FROM tb_produtos
                     GROUP BY id_tipo_produto)
ORDER BY id_tipo_produto;

--subconsultas na clausula FROM são chamadas de visões inline 

SELECT id_produto
FROM (SELECT id_produto
      FROM tb_produtos
      WHERE id_produto < 3);

SELECT p.id_produto, preco, dados_compra.count_produto
FROM tb_produtos p, (SELECT id_produto, COUNT(id_produto) count_produto
                     FROM tb_compras
                     GROUP BY id_produto) dados_compra
WHERE p.id_produto = dados_compra.id_produto;

/*
Subconsultas de várias linhas retornam várias tuplas
Podem ser usadas nos operadores IN, ANY e ALL (pode ser usado o NOT)
*/

SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto IN (1, 2, 3);

SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto IN (SELECT id_produto
                     FROM tb_produtos
                     WHERE nm_produto LIKE '%e%');

SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto NOT IN (SELECT id_produto
                         FROM tb_compras);

SELECT id_funcionario, nome, salario
FROM tb_funcionarios
WHERE salario < ANY(SELECT base_salario
                    FROM tb_grades_salarios);

SELECT id_funcionario, nome, salario
FROM tb_funcionarios
WHERE salario > ALL (SELECT teto_salario
                     FROM tb_grades_salarios);

SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos
WHERE (id_tipo_produto, preco) IN (SELECT id_tipo_produto, MIN(preco)
                                   FROM tb_produtos
                                   GROUP BY id_tipo_produto);

/*
Subconsultas correlacionadas é executada uma vez para cada linha e trabalha com nulos
Pode usar o EXITS ou o NOT EXITS para verificar se existe ou não (EXITS pode ser usados com valores literais tbm)
*/

SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos externa
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos interna
               WHERE interna.id_tipo_produto = externa.id_tipo_produto);

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

SELECT id_produto, nm_produto
FROM tb_produtos externa
WHERE NOT EXISTS (SELECT 1
                  FROM tb_compras interna
                  WHERE interna.id_produto = externa.id_produto);

SELECT id_tipo_produto, nm_tipo_produto
FROM tb_tipos_produtos externa
WHERE NOT EXISTS(SELECT 1
                 FROM tb_produtos interna
                 WHERE interna.id_tipo_produto = externa.id_tipo_produto);

SELECT id_tipo_produto, nm_tipo_produto
FROM tb_tipos_produtos 
WHERE id_tipo_produto NOT IN (SELECT id_tipo_produto
                              FROM tb_produtos);
                              
--usa o nvl para fazer o tratamento e retornar corretamente
SELECT id_tipo_produto, nm_tipo_produto
FROM tb_tipos_produtos 
WHERE id_tipo_produto NOT IN (SELECT NVL(id_tipo_produto, 0)
                              FROM tb_produtos);

/*
Subconsulta Alinhada
*/

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

/*
Subconsukta em update e delete
*/

SELECT salario
FROM tb_funcionarios
WHERE id_funcionario = 4;

UPDATE tb_funcionarios
SET salario = (SELECT AVG(teto_salario)
               FROM tb_grades_salarios)
WHERE id_funcionario = 4;

SELECT salario
FROM tb_funcionarios
WHERE id_funcionario = 4;

ROLLBACK;

SELECT salario
FROM tb_funcionarios
WHERE id_funcionario = 4;


--não ira funcionar pois não existe tuplas que corresponda o delete
DELETE
FROM tb_funcionarios
WHERE salario > (SELECT AVG(teto_salario)
                 FROM tb_grades_salario);


--exes do slide 3


--1
SELECT sobrenome, id_departamento, salario
FROM tb_empregado 
WHERE (id_departamento, salario) IN (SELECT id_departamento, salario
                                  FROM tb_empregado
                                  WHERE percentual_comissao > 0);

--prof
SELECT sobrenome, id_departamento, salario
FROM tb_empregado 
WHERE (salario, id_departamento) IN (SELECT salario, id_departamento
                                  FROM tb_empregado
                                  WHERE percentual_comissao > 0);
                                  
--2
SELECT emp.sobrenome, dep.nm_departamento, emp.salario
FROM tb_empregado emp
LEFT JOIN tb_departamento dep ON (emp.id_departamento = dep.id_departamento)
WHERE (emp.salario, emp.percentual_comissao) IN (SELECT emp.salario, emp.percentual_comissao
                                             FROM tb_empregado emp, tb_departamento dep
                                             WHERE dep.id_localizacao = 1700);

SELECT emp.sobrenome, dep.nm_departamento, emp.salario
FROM tb_empregado emp
LEFT JOIN tb_departamento dep ON (emp.id_departamento = dep.id_departamento)
WHERE (emp.salario, NVL(emp.percentual_comissao,0)) IN (SELECT emp.salario, emp.percentual_comissao
                                             FROM tb_empregado emp, tb_departamento dep
                                             WHERE dep.id_localizacao = 1700);
--prof
SELECT emp.sobrenome, dep.nm_departamento, emp.salario
FROM tb_empregado emp, tb_departamento dep
WHERE emp.id_departamento = dep.id_departamento AND
(salario, NVL(percentual_comissao,0)) IN (SELECT salario, NVL(percentual_comissao,0)
                                          FROM tb_empregado emp, tb_departamento dep
                                          WHERE emp.id_departamento = dep.id_departamento AND
                                             dep.id_localizacao = 1700);

---3 101
SELECT id_empregado, sobrenome, salario
FROM tb_empregado
WHERE (salario, NVL(percentual_comissao,0)) IN (SELECT salario, NVL(percentual_comissao,0)
                                        FROM tb_empregado
                                        WHERE sobrenome = 'Kochhar')
AND sobrenome != 'Kochhar';


---4
SELECT emp.id_empregado, emp.sobrenome, emp.id_departamento, loc.cidade
FROM tb_empregado emp
INNER JOIN tb_departamento dep ON (emp.id_departamento = dep.id_departamento)
INNER JOIN tb_localizacao loc ON (dep.id_localizacao = loc.id_localizacao)
WHERE cidade IN (SELECT cidade
                FROM tb_localizacao
                WHERE cidade LIKE('T%'));
