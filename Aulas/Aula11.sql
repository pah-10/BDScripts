/*
Subconsultas de uma única linha retornam zero ou no máximo 1 linha
Pode ser usada no where, having ou no from
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
