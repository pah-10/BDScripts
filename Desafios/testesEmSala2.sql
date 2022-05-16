--Exercício 1

DESCRIBE tb_empregado;

@ /home/oracle/Desktop/baseexercicios/item_5.sql

--Exercicio 2

SELECT id_empregado || ', ' || id_gerente || ', ' || id_departamento || ', ' || id_funcao || ', ' || nome || ', ' || sobrenome || ', ' || email || ', ' || telefone || ', ' || data_admissao || ', ' || percentual_comissao || ', ' || salario AS SAÍDA
FROM tb_empregado
ORDER BY 1;

--Exercicio 3
SELECT RPAD(nome || ' ' || sobrenome, 18) || ' ' || 
  RPAD(' ', salario/1000 + 1, '*') FUNCIONARIOS_E_SEUS_SALARIOS
FROM tb_empregado
ORDER BY salario DESC;

-- exercicios4
SELECT 'O departamento ' || dep.nm_departamento || ' possui ' || COUNT(emp.id_departamento) || ' quantidade de empregado(s) alocado(s)'
FROM tb_departamento dep
INNER JOIN tb_empregado emp ON (emp.id_departamento = dep.id_departamento)
GROUP BY dep.nm_departamento
ORDER BY 1;
