GRANT SELECT, INSERT, UPDATE ON tb_produtos TO fernando;
GRANT SELECT ON tb_funcionarios TO fernando;

GRANT UPDATE (sobrenome, salario)
  ON tb_funcionarios TO fernando;
  
GRANT SELECT ON tb_clientes TO fernando WITH GRANT OPTION;
  
SELECT *
FROM user_tab_privs_made
WHERE table_name = 'TB_PRODUTOS';
  
SELECT *
FROM user_col_privs_made;
  
CREATE PUBLIC SYNONYM produtosL FOR loja.tb_produtos;

SELECT *
FROM produtos;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
