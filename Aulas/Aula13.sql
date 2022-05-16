--Faz o merge entre as tabelas
MERGE INTO tb_produtos p
USING tb_produtos_alterados pa ON (p.id_produto = pa.id_produto)
WHEN MATCHED THEN
UPDATE
SET
p.id_tipo_produto = pa.id_tipo_produto,
p.nm_produto = pa.nm_produto,
p.ds_produto = pa.ds_produto,
p.preco = pa.preco,
p.fg_ativo = pa.fg_ativo
WHEN NOT MATCHED THEN
INSERT (
p.id_produto, p.id_tipo_produto, p.nm_produto,p.ds_produto, p.preco, p.fg_ativo)
VALUES(
pa.id_produto, pa.id_tipo_produto, pa.nm_produto,pa.ds_produto, pa.preco, pa.fg_ativo);

SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto IN (1,2,3,13,14,15);

INSERT INTO tb_clientes
VALUES (12, 'Geraldo', 'Henrique', '31-JUL-1977', '800-112233', 1);

COMMIT;

UPDATE tb_clientes
  SET nome = 'José'
WHERE id_cliente = 1;

SELECT *
FROM tb_clientes
ORDER BY 1;

ROLLBACK;

SELECT *
FROM tb_clientes
ORDER BY 1;

--toda transação tem inicio e fim
--DDL e DCL tem commit automatico
--DML falhado tem rollback automatico

--Savepoints
--produto 4 tem o preco 13,95
--produto 6 tem o preco 49,99

SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN (4,6);

--aumentando em 20% o preco do produto 4, preco agora é 20,09
UPDATE tb_produtos
SET preco = preco * 1.20
WHERE id_produto = 4;

COMMIT;

SAVEPOINT save1;

--aumentando em 30% o preco do produto 6, preco agora é 64,99
UPDATE tb_produtos
SET preco = preco * 1.30
WHERE id_produto = 6;

SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN (4,6);

ROLLBACK TO SAVEPOINT save1;

SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN (4,6);

-- Em transições concorrentes é preciso isolar as instruções
-- não é preciso isolar instruções read-only,apensa leitura, leitores como o select
--gravadores só bloqueiam gravadores que tentar acessar os mesmos objetos que ele está tentando modificar/criar;editar antes de gravar a finalização do processo
--leituras fantasmas 

--FLACSHACK

/* Valores iniciais do select
1 - 40
2 - 35
3 - 25.99
4 - 20,09
*/

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5;

UPDATE tb_produtos
  SET preco = preco * 0.75
WHERE id_produto <= 5;

commit;

/* Valores do select após o update
1 - 30
2 - 26.25
3 - 19.49
4 - 14.07
*/

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5;

--recuperando os dados anteriores com o tempo 
--Acessa o banco mirror/espelho e permite selects de verificação
EXECUTE DBMS_FLASHBACK.ENABLE_AT_TIME(SYSDATE - 10/1440);

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5;

--desativando o mirror
EXECUTE DBMS_FLASHBACK.DISABLE();

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5;

--com scn, o número gerado foi 12786993
VARIABLE scn_atual NUMBER;

EXECUTE :scn_atual := DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER();

PRINT scn_Atual;

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo)
VALUES (16, 1, 'Física', 'Livro sobre Física', 39.95, 1);

commit;

--executando como era antes do insert com o scn
EXECUTE DBMS_FLASHBACK.ENABLE_AT_SYSTEM_CHANGE_NUMBER(:scn_atual);

SELECT *
FROM tb_produtos
WHERE id_produto = 16;

EXECUTE DBMS_FLASHBACK.DISABLE();

CREATE TABLE tb_teste(
ID  INTEGER,
valor VARCHAR2(100)
);

BEGIN
  FOR v_loop IN 1..100 LOOP
    INSERT INTO tb_teste(id, valor)
    VALUES(v_loop, 'DBA_' || v_loop);
  END LOOP;
END;

SELECT *
FROM tb_teste;

DROP TABLE tb_teste;

SELECT *
FROM tb_teste;

FLASHBACK TABLE tb_teste TO BEFORE DROP;

SELECT *
FROM tb_teste;
