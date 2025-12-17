-- ============================================================================
-- SCRIPTS PRÁTICOS PARA O CURSO DE ADMINISTRAÇÃO ORACLE DBA
-- ============================================================================
-- Este arquivo contém scripts SQL prontos para praticar os conceitos
-- aprendidos em cada módulo do curso.
-- ============================================================================

-- ============================================================================
-- MÓDULO 1: FUNDAMENTOS DE BANCO DE DADOS E SQL ORACLE
-- ============================================================================

-- Criar as tabelas de exemplo (Livraria)
CREATE TABLE AUTORES (
    AUTOR_ID NUMBER PRIMARY KEY,
    NOME_AUTOR VARCHAR2(100) NOT NULL,
    PAIS_ORIGEM VARCHAR2(50)
);

CREATE TABLE LIVROS (
    LIVRO_ID NUMBER PRIMARY KEY,
    TITULO VARCHAR2(200) NOT NULL,
    ANO_PUBLICACAO NUMBER(4),
    PRECO NUMBER(10, 2),
    AUTOR_ID NUMBER REFERENCES AUTORES(AUTOR_ID)
);

-- Inserir dados de exemplo
INSERT INTO AUTORES VALUES (1, 'J.K. Rowling', 'Reino Unido');
INSERT INTO AUTORES VALUES (2, 'George Orwell', 'Reino Unido');
INSERT INTO AUTORES VALUES (3, 'Machado de Assis', 'Brasil');

INSERT INTO LIVROS VALUES (101, 'Harry Potter e a Pedra Filosofal', 1997, 35.00, 1);
INSERT INTO LIVROS VALUES (102, '1984', 1949, 28.50, 2);
INSERT INTO LIVROS VALUES (103, 'Dom Casmurro', 1899, 22.00, 3);
INSERT INTO LIVROS VALUES (104, 'A Revolução dos Bichos', 1945, 25.00, 2);

COMMIT;

-- Exercício 1: Selecionar todos os livros
SELECT * FROM LIVROS;

-- Exercício 2: Selecionar apenas título e ano
SELECT TITULO, ANO_PUBLICACAO FROM LIVROS;

-- Exercício 3: Livros publicados antes de 1950
SELECT * FROM LIVROS WHERE ANO_PUBLICACAO < 1950;

-- Exercício 4: Livros mais caros que 25 reais
SELECT TITULO, PRECO FROM LIVROS WHERE PRECO > 25;

-- Exercício 5: Join entre tabelas
SELECT L.TITULO, A.NOME_AUTOR
FROM LIVROS L
JOIN AUTORES A ON L.AUTOR_ID = A.AUTOR_ID;

-- Exercício 6: Preço médio dos livros
SELECT AVG(PRECO) AS PRECO_MEDIO FROM LIVROS;

-- Exercício 7: Contar livros por autor
SELECT A.NOME_AUTOR, COUNT(L.LIVRO_ID) AS TOTAL_LIVROS
FROM AUTORES A
LEFT JOIN LIVROS L ON A.AUTOR_ID = L.AUTOR_ID
GROUP BY A.NOME_AUTOR;

-- Exercício 8: Livros mais caros que a média
SELECT TITULO, PRECO
FROM LIVROS
WHERE PRECO > (SELECT AVG(PRECO) FROM LIVROS);

-- Exercício 9: Atualizar preço
UPDATE LIVROS SET PRECO = 32.75 WHERE TITULO = '1984';

-- Exercício 10: Deletar um livro
DELETE FROM LIVROS WHERE LIVRO_ID = 104;

-- Reverter deletions para próximas práticas
ROLLBACK;

-- ============================================================================
-- MÓDULO 2: ADMINISTRAÇÃO ORACLE I — BÁSICO
-- ============================================================================

-- Criar um novo usuário (execute como SYSTEM ou SYS)
-- CREATE USER analista IDENTIFIED BY Oracle123;

-- Conceder privilégios básicos
-- GRANT CREATE SESSION, CREATE TABLE TO analista;

-- Criar um tablespace
-- CREATE TABLESPACE APP_DATA 
-- DATAFILE '/u01/app/oracle/oradata/XE/app_data01.dbf' SIZE 50M;

-- Alterar usuário para usar novo tablespace
-- ALTER USER analista DEFAULT TABLESPACE APP_DATA QUOTA 40M ON APP_DATA;

-- Verificar usuários criados
-- SELECT USERNAME, CREATED, DEFAULT_TABLESPACE FROM DBA_USERS WHERE USERNAME = 'ANALISTA';

-- Verificar tablespaces
-- SELECT TABLESPACE_NAME, STATUS FROM DBA_TABLESPACES;

-- Verificar espaço livre em tablespaces
-- SELECT TABLESPACE_NAME, SUM(BYTES)/1024/1024 AS FREE_MB
-- FROM DBA_FREE_SPACE
-- GROUP BY TABLESPACE_NAME;

-- Verificar sessões ativas
-- SELECT USERNAME, SID, SERIAL#, STATUS FROM V$SESSION;

-- ============================================================================
-- MÓDULO 3: ADMINISTRAÇÃO ORACLE II — AVANÇADO
-- ============================================================================

-- Comandos RMAN (executar no RMAN, não no SQL*Plus)
-- $ rman target /
-- RMAN> BACKUP DATABASE;
-- RMAN> LIST BACKUP;
-- RMAN> RESTORE DATABASE VALIDATE;

-- Criar política de auditoria
-- CREATE AUDIT POLICY auditoria_geral
-- ACTIONS LOGON FAILED, CREATE USER;
-- AUDIT POLICY auditoria_geral;

-- Verificar registros de auditoria
-- SELECT AUDIT_TYPE, ACTION_NAME, DBUSERNAME, EVENT_TIMESTAMP
-- FROM UNIFIED_AUDIT_TRAIL
-- WHERE UNIFIED_AUDIT_POLICIES = 'AUDITORIA_GERAL'
-- ORDER BY EVENT_TIMESTAMP DESC;

-- ============================================================================
-- MÓDULO 4: PERFORMANCE E TUNING
-- ============================================================================

-- Gerar plano de execução
EXPLAIN PLAN FOR
SELECT L.TITULO, A.NOME_AUTOR
FROM LIVROS L
JOIN AUTORES A ON L.AUTOR_ID = A.AUTOR_ID
WHERE A.PAIS_ORIGEM = 'Reino Unido';

-- Ver o plano de execução
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Criar um índice
CREATE INDEX idx_livros_autor_id ON LIVROS(AUTOR_ID);

-- Coletar estatísticas
EXEC DBMS_STATS.GATHER_TABLE_STATS('HR', 'EMPLOYEES');

-- Visualizar índices criados
SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME FROM DBA_IND_COLUMNS;

-- ============================================================================
-- MÓDULO 5: ALTA DISPONIBILIDADE (Conceitual)
-- ============================================================================

-- Verificar status do banco de dados
SELECT NAME, OPEN_CURSORS, DB_UNIQUE_NAME FROM V$DATABASE;

-- Verificar modo de arquivo (necessário para RMAN)
SELECT LOG_MODE FROM V$DATABASE;

-- Verificar instâncias em um RAC
-- SELECT INSTANCE_NUMBER, INSTANCE_NAME, STATUS FROM GV$INSTANCE;

-- ============================================================================
-- LIMPEZA (Opcional - para remover dados de teste)
-- ============================================================================

-- Remover tabelas de teste
-- DROP TABLE LIVROS;
-- DROP TABLE AUTORES;

-- Remover usuário de teste
-- DROP USER analista CASCADE;

-- Remover tablespace
-- DROP TABLESPACE APP_DATA INCLUDING CONTENTS AND DATAFILES;

-- ============================================================================
-- FIM DOS SCRIPTS PRÁTICOS
-- ============================================================================
