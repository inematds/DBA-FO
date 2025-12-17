_**"Este material foi elaborado por um profissional com vasta experiência em administração de bancos de dados Oracle, tendo atuado como DBA por muitos anos, escrito livros e ministrado aulas. O objetivo deste curso é ser autoexplicativo e didático, com exercícios práticos que simulam desafios reais do dia a dia."**_

# Módulo 3: Administração Oracle II — Avançado

## Introdução

Este módulo eleva suas habilidades de DBA para o próximo nível. Aqui, trataremos de tópicos cruciais para a segurança e a resiliência de um ambiente de produção: estratégias de backup e recuperação, a moderna arquitetura multitenant e as melhores práticas de segurança e auditoria. Dominar esses conceitos é o que diferencia um administrador júnior de um profissional preparado para ambientes críticos.

## 3.1. Estratégias de Backup & Recovery com RMAN

Nenhum DBA pode dormir tranquilamente sem uma estratégia de backup sólida. A principal ferramenta da Oracle para isso é o **RMAN (Recovery Manager)**.

O RMAN é uma ferramenta de linha de comando que automatiza e gerencia todo o processo de backup e recuperação. Usar o RMAN em vez de copiar arquivos manualmente (backups a frio) oferece vantagens imensas:

*   **Backups Online (Quentes):** O RMAN pode fazer backup do banco de dados enquanto ele está aberto e em uso.
*   **Backups Incrementais:** O RMAN pode fazer backup apenas dos blocos de dados que mudaram desde o último backup, economizando espaço e tempo.
*   **Validação e Teste:** O RMAN pode verificar a integridade dos backups e simular uma restauração sem de fato realizá-la.
*   **Catálogo Centralizado:** O RMAN armazena todas as informações sobre os backups (o que foi copiado, quando e onde) no control file do banco de dados ou em um repositório centralizado (Recovery Catalog).

**Comandos Essenciais do RMAN:**

```rman
# Conectar ao RMAN
$ rman target /

# Fazer um backup completo do banco de dados
RMAN> BACKUP DATABASE;

# Listar os backups realizados
RMAN> LIST BACKUP;

# Simular a restauração de um tablespace para verificar o backup
RMAN> RESTORE TABLESPACE USERS PREVIEW;
```

## 3.2. Recuperação de Desastres

Um backup só é bom se a recuperação funcionar. O RMAN é a ferramenta para restaurar o banco de dados em diversos cenários de falha:

*   **Perda de um Data File:** Se um arquivo de dados for corrompido ou apagado, o DBA pode usar o RMAN para restaurar apenas aquele arquivo e recuperá-lo usando os redo logs.
*   **Falha de Mídia (Perda Total):** Em um cenário de desastre onde todo o servidor é perdido, o DBA precisa restaurar o banco de dados inteiro a partir do backup em um novo servidor.

O processo de recuperação geralmente envolve duas etapas:

1.  **RESTORE:** O RMAN restaura os arquivos de dados a partir do backup mais recente.
2.  **RECOVER:** O RMAN aplica as alterações registradas nos *archived redo logs* e nos *online redo logs* para trazer o banco de dados até o ponto mais recente possível no tempo (ou até um ponto específico no tempo, em recuperações mais avançadas).

## 3.3. Arquitetura Multitenant (CDB/PDB)

A partir da versão 12c, a Oracle introduziu uma arquitetura revolucionária chamada **Multitenant**. Ela muda a forma como gerenciamos múltiplos bancos de dados.

*   **CDB (Container Database):** É o banco de dados "contêiner", a instância principal. Ele gerencia a infraestrutura, os processos em segundo plano e os metadados comuns a todos.
*   **PDB (Pluggable Database):** É um banco de dados "plugável". Cada PDB é um banco de dados independente, com seus próprios schemas, tabelas e usuários, mas que "vive" dentro de um CDB. Para uma aplicação, um PDB se parece com um banco de dados tradicional.

**Vantagens da Arquitetura Multitenant:**

*   **Consolidação:** Em vez de ter dezenas de instâncias Oracle rodando em vários servidores (cada uma com sua própria memória e processos), podemos consolidar dezenas de PDBs em um único CDB. Isso economiza recursos de hardware drasticamente.
*   **Gerenciamento Simplificado:** Tarefas como backup, patching e upgrades podem ser feitas no nível do CDB, aplicando-se a todos os PDBs de uma só vez.
*   **Agilidade:** Criar um novo PDB (clonando um existente) é uma operação muito mais rápida do que instalar e criar um banco de dados inteiro do zero.

Como DBA, você precisa saber se conectar, gerenciar e monitorar tanto o CDB quanto os PDBs individualmente.

## 3.4. Segurança de Banco de Dados

A segurança vai muito além de `GRANT` e `REVOKE`. Um DBA sênior se preocupa com a proteção dos dados em várias camadas:

*   **Princípio do Menor Privilégio:** Conceda aos usuários apenas as permissões estritamente necessárias para realizar seu trabalho. Evite conceder roles poderosas como `DBA` para usuários de aplicação.
*   **Criptografia (Encryption):** O Oracle oferece o **Transparent Data Encryption (TDE)**, que permite criptografar dados "em repouso" (nos data files). Se alguém roubar os arquivos do servidor, os dados estarão ilegíveis sem a chave de criptografia.
*   **Virtual Private Database (VPD):** Também conhecido como *Fine-Grained Access Control*, o VPD permite anexar políticas de segurança às tabelas. Por exemplo, em uma tabela de `PEDIDOS`, uma política pode garantir que um gerente de vendas veja apenas os pedidos de sua própria região, mesmo que a query seja `SELECT * FROM PEDIDOS`.

## 3.5. Auditoria e Conformidade

Auditar significa registrar quem fez o quê e quando. A auditoria é essencial para investigações de segurança e para atender a requisitos de conformidade (como LGPD, SOX, etc.).

O Oracle fornece um sistema de auditoria unificada que permite configurar políticas para auditar ações específicas:

*   Logins falhos.
*   Conexões do usuário `SYS`.
*   `SELECT` em tabelas sensíveis (como `EMPREGADOS`).
*   Comandos `GRANT` ou `REVOKE`.

```sql
-- Criar uma política para auditar qualquer SELECT na tabela de salários
CREATE AUDIT POLICY audit_salarios
ACTIONS SELECT ON HR.EMPREGADOS;

-- Ativar a política
AUDIT POLICY audit_salarios;
```

Os registros de auditoria são armazenados em uma tabela interna e podem ser consultados pela view `UNIFIED_AUDIT_TRAIL`.

## Exercícios Práticos - Módulo 3

Estes exercícios exigem um ambiente Oracle com a edição Enterprise (para TDE e VPD) e, idealmente, com a arquitetura Multitenant. Se você estiver usando a Express Edition (XE), alguns exercícios (como os de TDE) podem não ser possíveis, mas os de RMAN e Auditoria ainda são aplicáveis.

### Questões

1.  **Backup com RMAN:** Conecte-se ao RMAN e execute um backup completo de todo o banco de dados. Após o backup, use o comando `LIST BACKUP` para verificar se o backup foi criado com sucesso.
2.  **Validação de Backup:** Ainda no RMAN, execute um comando para validar a capacidade de restauração (`RESTORE ... VALIDATE`) de todo o banco de dados. Isso irá ler os arquivos de backup para garantir que eles não estão corrompidos, sem de fato restaurar nada.
3.  **Simulação de Falha:** Este é um exercício clássico. Primeiro, identifique o caminho de um dos data files de um tablespace não crítico (como o `USERS` ou um que você criou para teste). Com o banco de dados aberto, renomeie ou mova esse arquivo no sistema operacional para simular uma perda de mídia. Em seguida, tente fazer uma consulta em uma tabela desse tablespace. Você deverá receber um erro.
4.  **Recuperação com RMAN:** Agora, use o RMAN para resolver o problema criado. O processo envolve colocar o tablespace offline, restaurar o data file perdido e depois recuperar o tablespace. Ao final, coloque o tablespace online novamente e verifique se o acesso aos dados foi restabelecido.
5.  **Auditoria:** Crie uma política de auditoria unificada chamada `auditoria_geral` que rastreie duas coisas: todas as tentativas de login que falharam (`LOGON FAILED`) e qualquer uso do privilégio de sistema `CREATE USER`. Ative essa política.
6.  **Teste de Auditoria:** Para testar a política, tente se conectar com um usuário e senha inválidos. Em seguida, conecte-se como DBA e crie um usuário de teste. Finalmente, consulte a view `UNIFIED_AUDIT_TRAIL` para ver se suas ações foram registradas.
7.  **Gerenciamento de PDB (se aplicável):** Se você estiver em um ambiente Multitenant, conecte-se ao CDB como `SYSDBA`. Use o comando `SHOW PDBS` para listar todos os PDBs e seus status. Tente fechar e depois abrir um dos PDBs (exceto o PDB$SEED).

---

### Gabarito dos Exercícios

<details>
<summary>Clique para ver as respostas</summary>

1.  ```rman
    # Conectar ao RMAN
    $ rman target /

    # Executar o backup
    RMAN> BACKUP DATABASE;

    # Listar o backup
    RMAN> LIST BACKUP OF DATABASE;
    ```
2.  ```rman
    RMAN> RESTORE DATABASE VALIDATE;
    ```
3.  Este exercício depende do seu sistema operacional. Por exemplo, em Linux:
    ```bash
    # Primeiro, descubra o nome do arquivo no SQL*Plus:
    SQL> SELECT FILE_NAME FROM DBA_DATA_FILES WHERE TABLESPACE_NAME = 'USERS';
    
    # Suponha que o resultado seja /u01/app/oracle/oradata/XE/users.dbf
    # Agora, no shell do SO:
    $ mv /u01/app/oracle/oradata/XE/users.dbf /u01/app/oracle/oradata/XE/users.dbf.bak
    
    # Tente uma query (vai falhar):
    SQL> SELECT * FROM HR.EMPLOYEES; -- Se a tabela estiver no tablespace USERS
    ```
4.  ```rman
    # Conectado ao RMAN
    RMAN> SQL 'ALTER TABLESPACE USERS OFFLINE';
    RMAN> RESTORE TABLESPACE USERS;
    RMAN> RECOVER TABLESPACE USERS;
    RMAN> SQL 'ALTER TABLESPACE USERS ONLINE';
    ```
5.  ```sql
    -- Conectado como SYSDBA
    CREATE AUDIT POLICY auditoria_geral
    ACTIONS LOGON FAILED, CREATE USER;
    
    AUDIT POLICY auditoria_geral;
    ```
6.  ```sql
    -- Tente uma conexão inválida em uma nova janela de terminal
    $ sqlplus usuario_invalido/senha_errada

    -- Conecte-se como DBA e crie um usuário
    SQL> CREATE USER teste_audit IDENTIFIED BY senha;

    -- Verifique os resultados da auditoria (pode levar alguns instantes para aparecer)
    SQL> SELECT AUDIT_TYPE, ACTION_NAME, UNIFIED_AUDIT_POLICIES 
         FROM UNIFIED_AUDIT_TRAIL 
         WHERE UNIFIED_AUDIT_POLICIES = 'AUDITORIA_GERAL' AND DBUSERNAME IN ('SYS', 'USUARIO_INVALIDO');
    ```
7.  ```sql
    -- Conectado ao CDB$ROOT como SYSDBA
    SQL> SHOW PDBS;
    
    -- Suponha que você tenha um PDB chamado PDB1
    SQL> ALTER PLUGGABLE DATABASE PDB1 CLOSE;
    SQL> SHOW PDBS;
    
    SQL> ALTER PLUGGABLE DATABASE PDB1 OPEN;
    SQL> SHOW PDBS;
    ```
</details>
