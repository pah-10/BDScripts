--sequencias

CREATE SEQUENCE seq_teste;

CREATE SEQUENCE seq_teste_2
START WITH 10 INCREMENT BY 5
MINVALUE 10 MAXVALUE 20
CYCLE CACHE 2 ORDER;

CREATE SEQUENCE seq_teste_3
START WITH 10 INCREMENT BY -1
MINVALUE 1 MAXVALUE 10
CYCLE CACHE 5;

--consulta as sequencias que sao proprietarias do usuário logado
SELECT *
FROM user_sequences
ORDER BY sequence_name;

--pseudocolunas das sequencias
--incrementa para o proximo valor
SELECT seq_teste.nextval
FROM dual;

--mostra o valor atual
SELECT seq_teste.currval
FROM dual;

SELECT seq_teste_2.nextval
FROM dual;

SELECT seq_teste_3.nextval
FROM dual;

CREATE TABLE tb_status_encomenda_2(
id_status INTEGER CONSTRAINT pk_status_enc_2 PRIMARY KEY,
status    VARCHAR2(10),
ultima_modificacao  DATE DEFAULT SYSDATE
);

CREATE SEQUENCE seq_status_enc_2 NOCACHE;

INSERT INTO tb_status_encomenda_2(id_status, status, ultima_modificacao)
VALUES (seq_status_enc_2.nextval,'Enviado','01-JAN-2013');

INSERT INTO tb_status_encomenda_2(id_status, status, ultima_modificacao)
VALUES (seq_status_enc_2.nextval,'Pendente','01-MAR-2013');

SELECT *
FROM tb_status_encomenda_2;

--instruções DDL em sequencias
ALTER SEQUENCE seq_teste
INCREMENT BY 2;

DROP SEQUENCE seq_teste_3;

SELECT *
FROM tb_clientes
WHERE sobrenome = 'Brown';

--index com algoritmo arvore B
CREATE INDEX idx_clientes_sobrenome
ON tb_clientes(sobrenome);

CREATE UNIQUE INDEX idx_clientes_telefone
ON tb_clientes(telefone);

CREATE INDEX idx_func_nome_sobre
ON tb_funcionarios(nome, sobrenome);

--neste caso a indexação não é usada porque como a funcao foi utilizada e a indexação não é baseada na função, o banco descarta o index
SELECT nome, sobrenome
FROM tb_clientes
WHERE UPPER(sobrenome) = 'BROWN';

--index criado baseado em função
CREATE INDEX idx_funcao_clientes_sobrenome
ON tb_clientes(UPPER(sobrenome));

--configuração do argmento que habilita a utilização dos indixes baseados em funcao, deve ser feito pelo usuário do system
--ALTER SYSTEM SET QUERY_REWRITE_ENABLED = TRUE;

SELECT index_name, table_name, uniqueness, status
FROM user_indexes
WHERE table_name IN ('TB_CLIENTES','TB_FUNCIONARIOS')
ORDER BY index_name;

SELECT index_name, table_name, column_name
FROM user_ind_columns
WHERE table_name IN ('TB_CLIENTES','TB_FUNCIONARIOS')
ORDER BY index_name;

--renomeando o index
ALTER INDEX idx_clientes_telefone
RENAME TO idx_clientes_telefone_nr;

--removendo a tabela indexadora
DROP INDEX idx_clientes_telefone_nr;

--criando index com algortimo bitmap
CREATE BITMAP INDEX idx_status_enc
ON tb_status_encomenda_2(status);

--visoes
--visões não fazem o armazenamento de tuplas e as linhas são armazenadas em tabelas

--permissão que deve ser feita no root/system e atribui permissão para a uutilização de views em um usuário
--GRANT CREATE VIEW TO loja;

--criando view simples
CREATE VIEW view_produtos_baratos AS
  SELECT *
  FROM tb_produtos
  WHERE preco < 15.00;

CREATE VIEW view_funcionarios AS
  SELECT id_funcionario, id_gerente, nome, sobrenome, cargo, fg_ativo
  FROM tb_funcionarios;

--select usando a view
SELECT *
FROM view_produtos_baratos;

SELECT *
FROM view_funcionarios;

--insert com visão
INSERT INTO view_produtos_baratos(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES (33, 1, 'DVD-R', 13.50, 1);

SELECT id_produto, nm_produto, preco
FROM view_produtos_baratos
WHERE id_produto = 33;

INSERT INTO view_produtos_baratos(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES (43, 1, 'Mouse Optico', 16.50, 1);

--não recupera nada porque o filtro tras apenas os que tem o preço menor que 15
SELECT id_produto, nm_produto, preco
FROM view_produtos_baratos
WHERE id_produto = 43;

INSERT INTO view_funcionarios(id_funcionario, id_gerente, nome, sobrenome, cargo)
VALUES (100, 1, 'Jefferson', 'Mendes', 'DBA');

SELECT id_funcionario, nome, sobrenome, salario
FROM tb_funcionarios
WHERE id_funcionario = 100;

CREATE VIEW view_produtos_baratos_2 AS
  SELECT *
  FROM tb_produtos
  WHERE preco < 15.00
WITH CHECK OPTION CONSTRAINT view_produtos_baratos_2_preco;

--da erro porque o valor é acima do permetido pela view
INSERT INTO view_produtos_baratos_2(id_produto, id_tipo_produto, nm_produto, preco)
VALUES (53, 1, 'Submarino', 19.50);

CREATE VIEW view_produtos_baratos_3 AS
  SELECT *
  FROM tb_produtos
  Where preco < 15.00
WITH READ ONLY CONSTRAINT view_prod_baratos_3_read_only;

--da erro porque a visão e de apenas leitura
INSERT INTO view_produtos_baratos_3(id_produto, id_tipo_produto, nm_produto, preco)
VALUES (34, 1, 'E-Books Ms Project', 19.50);

DESCRIBE view_produtos_baratos_3;

SELECT view_name, text_length, text
FROM user_views
ORDER BY view_name;

SELECT constraint_name, constraint_type, status, deferrable, deferred
FROM user_constraints
WHERE table_name IN ('VIEW_PRODUTOS_BARATOS_2', 'VIEW_PRODUTOS_BARATOS_3')
ORDER BY constraint_name;

--visões complexas















