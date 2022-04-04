
SELECT emp.id_empregado, emp.nome || ' ' || emp.sobrenome AS "Nome", fun.ds_funcao, emp.data_admissao
FROM tb_empregado emp
INNER JOIN tb_funcao fun ON emp.id_funcao = fun.id_funcao
ORDER BY emp.id_empregado;
