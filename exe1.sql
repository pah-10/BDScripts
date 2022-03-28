---------------------------------------------
----Parte 1

--Faz a criação do usuário exercicios
--Concede a permissao de conexao e edicao
CREATE USER exercicios IDENTIFIED BY 123456;
GRANT resource, connect TO exercicios;


---------------------------------------------
----Parte 2

--Criacao da tb_regiao
CREATE TABLE tb_regiao(
    id_regiao NUMBER CONSTRAINT nn_id_regiao NOT NULL,
    nm_regiao VARCHAR(25)
);

CREATE UNIQUE INDEX pk_id_regiao
ON tb_regiao(id_regiao);

ALTER TABLE tb_regiao
ADD (
    CONSTRAINT pk_id_regiao PRIMARY KEY (id_regiao)
);

---------------------------------------------
----Parte 3

CREATE TABLE tb_pais(
    id_pais     CHAR(2) CONSTRAINT nn_id_pais NOT NULL,
    nm_pais     VARCHAR2(40),
    id_regiao   NUMBER,

    CONSTRAINT pk_id_pais PRIMARY KEY(id_pais)
);

ALTER TABLE tb_pais
ADD (
    CONSTRAINT fk_regiao_pais FOREIGN KEY (id_regiao) REFERENCES tb_regiao(id_regiao)
);

---------------------------------------------
----Parte 4

CREATE TABLE tb_localizacao(
    id_localizacao    NUMBER(4),
    id_pais           CHAR(2),
    endereco          VARCHAR2(40),
    cep               VARCHAR2(12),
    cidade            VARCHAR2(30) CONSTRAINT nn_loc_cidade NOT NULL,
    estado            VARCHAR2(25)
);

CREATE UNIQUE INDEX pk_id_localizacao
ON tb_localizacao(id_localizacao);

ALTER TABLE tb_localizacao
ADD (
    CONSTRAINT pk_id_loc PRIMARY KEY(id_localizacao),
    CONSTRAINT fk_id_pais FOREIGN KEY(id_pais) REFERENCES tb_pais(id_pais)
);

CREATE SEQUENCE seq_localizacao
START WITH      3300
INCREMENT BY    100
MAXVALUE        9900
NOCACHE
NOCYCLE;

---------------------------------------------
----Parte 5

CREATE TABLE tb_departamento(
    id_departamento     NUMBER(4),
    nm_departamento     VARCHAR2(30) CONSTRAINT nn_nm_depto NOT NULL,
    id_gerente          NUMBER(6),
    id_localizacao      NUMBER(4)
);

CREATE UNIQUE INDEX pk_id_departamento
ON tb_departamento(id_departamento);

ALTER TABLE tb_departamento
ADD (
    CONSTRAINT pk_id_departamento PRIMARY KEY(id_departamento),
    CONSTRAINT fk_loc_departamento FOREIGN KEY(id_localizacao) REFERENCES tb_localizacao(id_localizacao)
);
     
CREATE SEQUENCE seq_departamento
START WITH      280
INCREMENT BY    10
MAXVALUE        9990
NOCACHE
NOCYCLE;

---------------------------------------------
----Parte 6

CREATE TABLE tb_funcao(
    id_funcao     VARCHAR2(10),
    ds_funcao     VARCHAR2(35) CONSTRAINT nn_ds_funcao NOT NULL,
    base_salario  NUMBER(8,2),
    teto_salario  NUMBER(8,2)
);

CREATE UNIQUE INDEX pk_id_funcao
ON tb_funcao(id_funcao);

ALTER TABLE tb_funcao
ADD (
    CONSTRAINT pk_id_funcao PRIMARY KEY(id_funcao)
);

---------------------------------------------
----Parte 7

CREATE TABLE tb_empregado(
    id_empregado          NUMBER(6),
    nome                  VARCHAR2(20),
    sobrenome             VARCHAR2(25) CONSTRAINT nn_emp_sobrenome NOT NULL,
    email                 VARCHAR2(25) CONSTRAINT nn_emp_email NOT NULL,
    telefone              VARCHAR2(20),
    data_admissao         DATE CONSTRAINT nn_emp_dt_adm NOT NULL,
    id_funcao             VARCHAR2(10) CONSTRAINT nn_emp_funcao NOT NULL,
    salario               NUMBER(8,2),
    percentual_comissao   NUMBER(2,2),
    id_gerente            NUMBER(6),
    id_departamento       NUMBER(4),
    CONSTRAINT min_emp_salario CHECK (salario > 0),
    CONSTRAINT un_emp_email UNIQUE (email)
);

CREATE UNIQUE INDEX pk_id_emp
ON tb_empregado (id_empregado);

ALTER TABLE tb_empregado
ADD (
    CONSTRAINT pk_id_emp PRIMARY KEY (id_empregado),
    CONSTRAINT fk_emp_depto FOREIGN KEY(id_departamento) REFERENCES tb_departamento,
    CONSTRAINT fk_emp_funcao FOREIGN KEY (id_funcao) REFERENCES tb_funcao(id_funcao),
    CONSTRAINT fk_emp_gerente FOREIGN KEY (id_gerente) REFERENCES tb_empregado
);
      
ALTER TABLE tb_departamento
ADD (
    CONSTRAINT fk_gerente_depto FOREIGN KEY (id_gerente) REFERENCES tb_empregado(id_empregado)
);

CREATE SEQUENCE seq_empregado
START WITH    207
INCREMENT BY  1
NOCACHE
NOCYCLE;

---------------------------------------------
----Parte 8

CREATE TABLE tb_historico_funcao(
    id_empregado        NUMBER(6) CONSTRAINT nn_hist_emp_id_emp NOT NULL,
    data_inicio         DATE CONSTRAINT nn_hist_emp_dt_inicio NOT NULL,
    data_termino        DATE CONSTRAINT nn_hist_emp_dt_termino NOT NULL,
    id_funcao           VARCHAR2(10) CONSTRAINT nn_hist_emp_id_funcao NOT NULL,
    id_departamento     NUMBER(4),

    CONSTRAINT ck_hist_emp_data_intervalo CHECK(data_termino > data_inicio)
);

CREATE UNIQUE INDEX pk_hist_emp_id_emp
ON tb_historico_funcao(id_empregado, data_inicio);

ALTER TABLE tb_historico_funcao
ADD (
    CONSTRAINT pk_hist_emp_id_emp PRIMARY KEY (id_empregado, data_inicio),
    CONSTRAINT fk_hist_funcao_funcao FOREIGN KEY(id_funcao) REFERENCES tb_funcao,
    CONSTRAINT fk_hist_funcaop_emp FOREIGN KEY (id_empregado) REFERENCES tb_empregado,
    CONSTRAINT fk_hist_funcao_depto FOREIGN KEY (id_departamento) REFERENCES tb_departamento
);   

-- Selects das tabelas para verificação

/*

SELECT * 
FROM tb_regiao;

SELECT *
FROM tb_pais;

SELECT *
FROM tb_localizacao;

SELECT *
FROM tb_departamento;

SELECT *
FROM tb_funcao;

SELECT *
FROM tb_empregado;

SELECT *
FROM tb_historico_funcao;

*/