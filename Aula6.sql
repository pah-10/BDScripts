--Inicio slide 3 -- funções

--tras os valores dos caracters em char e em ascii
SELECT ASCII ('a'), ASCII('A'), ASCII('z'), ASCII('Z'), ASCII('0'),ASCII('9')
FROM dual;

SELECT CHR(97), CHR(65), CHR(122), CHR(90), CHR(48), CHR(57)
FROM dual;

--faz a concatenaçao e retorna um novo string
SELECT CONCAT(nome, sobrenome)
FROM tb_funcionarios;

--converte a primeira letra em maiuscula
SELECT id_produto, INITCAP(ds_produto)
FROM tb_produtos;

--procura o string x e retorna a posição 
SELECT nm_produto, INSTR(nm_produto, 'Science')
FROM tb_produtos
WHERE id_produto = 1;


--exibe a posicao da 2 ocorrencia do caracter desejado, comecando do inicio
SELECT nm_produto, INSTR(nm_produto, 'e', 1, 2)
FROM tb_produtos
WHERE id_produto = 1;

--obtem o numero de caracters 
SELECT nm_produto, LENGTH(nm_produto)
FROM tb_produtos;

--funcoes que convertem todas as strings em maiusculo ou minusculo
SELECT UPPER(nome), LOWER(sobrenome)
FROM tb_funcionarios;

--funçoes que preenche a esquerda ou a direita até a quantidade de caracters desejada
SELECT RPAD(nm_produto, 30, '.'), LPAD(preco, 8, '*+')
FROM tb_produtos
WHERE id_produto < 4;

--faz o recorte da string por um string de corte ou pelo caracter espaço
SELECT
  LTRIM(' Olá pessoal, tudo joia?'),
  RTRIM('Oi tudo bem!abcabc', 'abc'),
  TRIM('O' FROM 'OOOTreinamento em Oracle!OOOOOOOO')
FROM dual;

--Recupera as colunas nulas com o texto escolhido
SELECT id_cliente, NVL(telefone, 'Telefone Inexistente')
FROM tb_clientes
ORDER BY id_cliente DESC;

--recupera os valores das colunas apenas com textos recem programados
SELECT id_cliente, NVL2(telefone, 'Telefone existente', 'Telefone inexistente')
FROM tb_clientes
ORDER BY id_cliente DESC;
