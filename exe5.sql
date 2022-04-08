/*

Exercício 5 - Laboratório de banco de dados
Paola Paulina De Jesus Santa Capita

*/

---------------------------------------
-- Exe 1

SELECT 'O identificador da ' || ds_funcao || ' é o ID: ' || id_funcao AS "Descrição da Função"
FROM tb_funcao;

---------------------------------------
-- Exe 2

SELECT ((22/7) * 6000 * 6000) AS Área
FROM dual;

---------------------------------------
-- Exe 3

SELECT nm_departamento
FROM tb_departamento 
WHERE nm_departamento LIKE('%ing');

---------------------------------------
-- Exe 4

SELECT ds_funcao, base_salario, (teto_salario - base_salario) AS Diferença
FROM tb_funcao
WHERE ds_funcao = 'Presidente' OR ds_funcao LIKE('Gerente%')
ORDER BY Diferença DESC, ds_funcao ASC;

---------------------------------------
-- Exe 5

--Ideia de como funciona a consulta
SELECT id_empregado, nome, salario, (salario * 12) AS Salario_Anual, 7 AS Aliquota, ((salario * 12) * 7)
FROM tb_empregado;

-- consulta com a variavel temporaria

SELECT id_empregado, nome, salario, (salario * 12) AS Salario_Anual, &&Aliquota, ((salario * 12) * &&Aliquota)
FROM tb_empregado;

-- consulta com a variavel definida

DEFINE Aliquota = 7

SELECT id_empregado, nome, salario, (salario * 12) AS Salario_Anual, &Aliquota, ((salario * 12) * &Aliquota)
FROM tb_empregado;
