--CONECTAR como SYSTEM

--mostra qual usuário esta conectado
SHOW USER;

--apenas a criação do user
CREATE USER jean IDENTIFIED BY master;

--usuário criado com tablespace padrão e temporário
CREATE USER henrique IDENTIFIED BY 0800
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

--concedendo permissões para que o usuário possa se movimentar pelo banco
GRANT CREATE SESSION TO jean;

--criando usuário e permissões ao mesmo tempo
CREATE USER fernando IDENTIFIED BY fernando1234;
CREATE USER sonia IDENTIFIED BY sonia1234;
GRANT CREATE SESSION TO fernando, sonia;

--Alterando senha
ALTER USER jean IDENTIFIED BY senha123alterada;

--excluindo usuário
DROP USER jean;

--concedendo privilegios de sistema ao usuário 
GRANT CREATE SESSION,
  CREATE USER,
  CREATE TABLE TO fernando;

--with admin option permite que o usuário conceda o mesmo privilegio para outro usuário
--o exemplo abaixo permite que fernando conceda o EXECUTE ANY PROCEDURE para ouros usuários
GRANT EXECUTE ANY PROCEDURE TO fernando WITH ADMIN OPTION;

SHOW USER;

GRANT EXECUTE ANY PROCEDURE TO PUBLIC;

REVOKE CREATE TABLE FROM fernando;

GRANT CREATE SYNONYM TO fernando;

GRANT CREATE PUBLIC SYNONYM TO loja;













