SHOW USER;

GRANT EXECUTE ANY PROCEDURE TO sonia;

SELECT *
FROM user_sys_privs
ORDER BY privilege;

CREATE USER roberto IDENTIFIED BY roberto1234;

DROP USER roberto;

GRANT SELECT ON loja.tb_clientes TO sonia;

SELECT *
FROM user_tab_privs_recd;

SELECT *
FROM user_col_privs_recd;

SELECT *
FROM loja.tb_clientes;

SELECT *
FROM loja.tb_compras;

CREATE SYNONYM clientes FOR loja.tb_clientes;

SELECT *
FROM clientes;
