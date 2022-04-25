-----------------------------------------
--NP1 Prática LBD
--Paola Paulina De Jesus Santa Capita


------------------------------
--exe1

SELECT nome || ' recebe ' || salario || ' mensalmente, mas deseja ' || (salario * 3) AS "Salário dos Sonhos"
FROM tb_empregado
ORDER BY salario ASC;

------------------------------
--exe2

SELECT nome
FROM tb_empregado
WHERE REGEXP_COUNT(LOWER(nome),'e[:alpha:]{0}') = 2
AND id_departamento = 60 
AND id_gerente = 102;

------------------------------
--exe 3

SELECT NVL(ger.nome, 'Os acionistas') || ' gerencia(m) ' || emp.nome
FROM tb_empregado ger
RIGHT JOIN tb_empregado emp ON (ger.id_empregado  = emp.id_gerente)
ORDER BY ger.nome DESC;

------------------------------
--exe 4

SELECT emp.nome, emp.sobrenome, emp.salario, emp.id_funcao
FROM tb_empregado emp, tb_funcao func
WHERE emp.id_funcao IN (func.id_funcao);  
