--exercício 1

SELECT *
FROM tb_empregado;

SELECT emp.nome || ' trabalha para ' || dep.id_departamento || ' localizado na cidade ' || loc.cidade || ' estado ' || loc.estado || ' pais ' || p.nm_pais
FROM tb_empregado emp, tb_departamento dep, tb_localizacao loc, tb_pais p
WHERE emp.id_departamento = dep.id_departamento AND 
dep.id_localizacao = loc.id_localizacao AND
loc.id_pais = p.id_pais
ORDER BY emp.nome;


--exercicio 2
SELECT nome || ' ' || sobrenome
FROM tb_empregado 
WHERE LOWER(nome) LIKE 'e_____e%' AND
id_departamento = 80 OR id_gerente = 148
ORDER BY nome;

--exercício 3 - erro
SELECT NVL(g.nome, 'Os acionistas') || ' gerencia ' || emp.nome
FROM tb_empregado emp, tb_empregado g
WHERE emp.id_gerente = g.id_empregado
ORDER BY g.nome DESC;

--exercício 4

SELECT sobrenome,
  ROUND((SYSDATE - data_admissao), 0) AS "Número de dias trabalhados"
FROM tb_empregado
WHERE id_departamento = 80 AND
ROUND((SYSDATE - data_admissao), 0) > 5000
ORDER BY 1;
