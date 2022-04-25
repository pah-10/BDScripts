--Localiza a posição da expressar solicitada

SELECT
  REGEXP_INSTR('Teste de expressão regular', 'e', 6, 2) AS resultado
FROM dual;l

-- faz a substituição da uma string correspondendo por uma expressao desejada
SELECT
  REGEXP_REPLACE('Teste de expressão regular', 'd[[:alpha:]]{1}','Oracle') AS resultado
FROM dual;

--extrai uma parte da string desejada que corresponda ao desejado
SELECT
  REGEXP_SUBSTR('Teste de expressão regular', 'e[[:alpha:]]{8}') AS resultado
FROM dual;

--Retorna o número de vezes que a expressao regular ocorreu na string
SELECT
  REGEXP_COUNT('teste teste teste teste de expressão regular','t[[:alpha:]]{4}') AS resultado
FROM dual;

SELECT
  REGEXP_COUNT('teste teste de expressão regular','t[[:alpha:]]{4}') AS resultado
FROM dual;

--Funções agregadas Utilizadas em relatórios analiticos
--valores nulos são ignorados pelas funções agregadas

--obtem o valor medio de preco
SELECT ROUND(AVG(preco),2.00)
FROM tb_produtos;

SELECT ROUND(AVG(preco),3.00)
FROM tb_produtos;

-- obtem o valor medio mais 2 em cada linha
SELECT AVG(preco + 2.00)
FROM tb_produtos;

--O DISTINCT utiliza para exluir valores identicos na coluna preco
SELECT AVG(DISTINCT preco)
FROM tb_produtos;

SELECT COUNT(id_produto)
FROM tb_produtos;

SELECT COUNT(ROWID)
FROM tb_produtos;


--MAX e MIN de algo
SELECT MAX(preco), MIN(preco)
FROM tb_produtos;

--localizando o nome do produto que tem o maior valor de preco utilizando o uma subsection
SELECT nm_produto, preco
FROM tb_produtos
WHERE preco = (SELECT MAX(preco)
              FROM tb_produtos);

--obtem os strings Máximo  minímo da coluna nm_produto e tb_prudto, faz a ordenação. Utilizar o order by
SELECT MAX(nm_produto), MIN(nm_produto)
FROM tb_produtos;

--MAX e minimo em datas, o max tras o mais recente e o min o mais distante
SELECT MAX(dt_nascimento), MIN(dt_nascimento)
FROM tb_clientes;

--Função que obtem o desvio padrão
SELECT STDDEV(preco)
FROM tb_produtos;

--Função que obtem o desvio padrão
SELECT ROUND(STDDEV(preco),2)
FROM tb_produtos;

--soma todos os valores presentes em x e retorna o total
SELECT SUM(preco)
FROM tb_produtos;

--obtem a variancia dos valores, a variancia é o quadrado do desvio padrao
SELECT VARIANCE(preco)
FROM tb_produtos;

--AGRUPAMENTO DE linhas, faz a junção de linhas duplicatas
SELECT id_tipo_produto
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto DESC;

--varias colunas em um grupo
SELECT id_produto, id_cliente
FROM tb_compras
GROUP BY id_produto, id_cliente;

--para saber quantos agrupamentos foram feitos em cada tabela
SELECT id_tipo_produto, COUNT(ROWID) AS "Quantidade de Aparencias"
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

--para fazer a agregação 
SELECT tipo.nm_tipo_produto, prod.id_tipo_produto, ROUND(AVG(prod.preco),2) as "Media de preço"
FROM tb_produtos prod
INNER JOIN tb_tipos_produtos tipo ON prod.id_tipo_produto = tipo.id_tipo_produto
GROUP BY prod.id_tipo_produto, tipo.nm_tipo_produto
ORDER BY tipo.nm_tipo_produto;

