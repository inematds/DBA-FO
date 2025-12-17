_**"Este material foi elaborado por um profissional com vasta experiência em administração de bancos de dados Oracle, tendo atuado como DBA por muitos anos, escrito livros e ministrado aulas. O objetivo deste curso é ser autoexplicativo e didático, com exercícios práticos que simulam desafios reais do dia a dia."**_

# Módulo 2: Administração Oracle I — Básico

## Introdução

Com os fundamentos de SQL estabelecidos, é hora de mergulhar no mundo da administração de bancos de dados Oracle. Este módulo aborda as tarefas essenciais que todo DBA iniciante precisa dominar: desde a instalação do software até o gerenciamento da estrutura interna do banco de dados.

## 2.1. Instalação e Configuração do Oracle Database

A primeira tarefa de um DBA é, muitas vezes, instalar o banco de dados. O Oracle Database pode ser instalado em diversas plataformas (Linux, Windows, etc.). O processo de instalação, embora guiado por um assistente gráfico (Oracle Universal Installer - OUI), exige atenção a detalhes importantes:

*   **Edição do Banco de Dados:** A Oracle oferece diferentes edições (Enterprise, Standard, Express). Para estudos, a **Express Edition (XE)** é gratuita e ideal.
*   **Diretórios de Instalação:** É crucial definir o `ORACLE_BASE` (diretório raiz da instalação) e o `ORACLE_HOME` (diretório específico da versão do software).
*   **Criação do Banco de Dados:** Durante a instalação, você pode optar por criar um banco de dados inicial. Aqui, você definirá o nome global do banco (Global Database Name), o SID (System Identifier) e as senhas para usuários administrativos como `SYS` e `SYSTEM`.

## 2.2. Arquitetura Interna do Oracle

![Arquitetura Oracle](https://private-us-east-1.manuscdn.com/sessionFile/YtwaOR8HqwbZ0tIPDb8GQZ/sandbox/FlgnfiUcbySTEyiohickDa-images_1765944434610_na1fn_L2hvbWUvdWJ1bnR1L2N1cnNvX29yYWNsZV9kYmEvYXJxdWl0ZXR1cmFfb3JhY2xlXzE.jpg?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9wcml2YXRlLXVzLWVhc3QtMS5tYW51c2Nkbi5jb20vc2Vzc2lvbkZpbGUvWXR3YU9SOEhxd2JaMHRJUERiOEdRWi9zYW5kYm94L0ZsZ25maVVjYnlTVEV5aW9oaWNrRGEtaW1hZ2VzXzE3NjU5NDQ0MzQ2MTBfbmExZm5fTDJodmJXVXZkV0oxYm5SMUwyTjFjbk52WDI5eVlXTnNaVjlrWW1FdllYSnhkV2wwWlhSMWNtRmZiM0poWTJ4bFh6RS5qcGciLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE3OTg3NjE2MDB9fX1dfQ__&Key-Pair-Id=K2HSFNDJXOU9YS&Signature=KCXgqrOUMBaMMo3H6eprL-U4MruvlJmqsvbhPaFjVDdKR142PoKrKr3tt1GrchtTFMxynij0N6kCH00ANIoZ-qD4mEHiAduTErmfG14O85UhhpSWJk72~JI8bWKsaj~jkr-X8ek~VrMv7l7gyzfPL2OByB~3j5rd2Onr2V6c829uMhvlZy6y41idX0AkxC61JknfpvEGaT2lJzM9rGc2y7wo1f58bhV-drya35U9BKPjTYS46OaPQIWPl4EouVCyNnlWmBh2CCw6fMm-Vz8nmyGPJxGQNxHAtjnEipzme5-9S6NNVu46iTFYb-oHSV7YFW7fw2rpVBCNj8nbC2yKZw__)

Para administrar um banco de dados Oracle, é fundamental entender sua arquitetura. Ela é dividida em duas partes principais: a **Instância** e o **Banco de Dados**.

*   **Instância (Instance):** É o conjunto de processos em segundo plano (background processes) e a área de memória alocada na RAM do servidor. A instância é volátil; ela existe enquanto o banco de dados está "no ar".
    *   **SGA (System Global Area):** A principal área de memória da instância, compartilhada por todos os usuários. Contém componentes como o *Buffer Cache* (armazena blocos de dados lidos do disco), *Shared Pool* (armazena queries SQL e o dicionário de dados) e *Redo Log Buffer*.
    *   **PGA (Program Global Area):** Uma área de memória privada para cada processo de servidor, usada para ordenação de dados (sorts) e informações da sessão do usuário.
*   **Banco de Dados (Database):** É o conjunto de arquivos físicos armazenados em disco.
    *   **Data Files:** Contêm os dados reais das tabelas e índices.
    *   **Control Files:** Arquivos críticos que contêm metadados sobre a estrutura do banco de dados (nome do banco, localização dos data files, etc.).
    *   **Redo Log Files:** Registram todas as alterações feitas no banco de dados, garantindo a recuperabilidade em caso de falha.

## 2.3. Gerenciamento de Usuários, Perfis e Permissões

Um dos papéis centrais do DBA é controlar quem acessa o banco de dados e o que cada um pode fazer.

*   **Usuários (Users):** Para se conectar ao Oracle, é preciso ter uma conta de usuário. Cada usuário é dono de um *schema*, que é uma coleção de objetos (tabelas, views, etc.).

    ```sql
    -- Criar um novo usuário
    CREATE USER carlos IDENTIFIED BY SuaSenha123;
    ```

*   **Permissões (Privileges):** São os direitos concedidos a um usuário. Existem dois tipos:
    *   **Privilégios de Sistema:** Permitem executar ações no nível do banco (ex: `CREATE SESSION`, `CREATE TABLE`).
    *   **Privilégios de Objeto:** Permitem manipular objetos de outro usuário (ex: `SELECT ON empregados`, `UPDATE ON departamentos`).

    ```sql
    -- Conceder permissão para o usuário se conectar
    GRANT CREATE SESSION TO carlos;

    -- Conceder permissão para o usuário criar tabelas
    GRANT CREATE TABLE TO carlos;
    ```

*   **Perfis (Profiles):** São conjuntos de limites para os recursos do banco de dados (ex: número de sessões simultâneas, tempo de CPU por chamada, políticas de senha). Eles são usados para garantir que um usuário não consuma recursos excessivos.

## 2.4. Tablespaces e Arquivos de Dados

No Oracle, os dados não são armazenados diretamente em "arquivos de tabela". Em vez disso, a estrutura é mais abstrata e flexível:

*   **Tablespace:** É uma unidade lógica de armazenamento. Um banco de dados é dividido em um ou mais tablespaces. Por exemplo, podemos ter um tablespace para tabelas, outro para índices, etc. Isso facilita a organização e o gerenciamento.
*   **Data File:** É o arquivo físico no sistema operacional que corresponde a um tablespace. Um tablespace pode ser composto por um ou mais data files.

Essa separação permite que o DBA gerencie o espaço de forma granular. Se um tablespace ficar cheio, basta adicionar um novo data file a ele, sem precisar reestruturar as tabelas.

```sql
-- Criar um novo tablespace chamado 'DADOS_APP' com um arquivo de 100MB
CREATE TABLESPACE DADOS_APP
DATAFILE '/u01/app/oracle/oradata/XE/dados_app01.dbf' SIZE 100M;

-- Alterar o tablespace padrão de um usuário
ALTER USER carlos DEFAULT TABLESPACE DADOS_APP;
```

## 2.5. Monitoramento Básico

Um DBA proativo monitora constantemente a saúde do banco de dados. As principais áreas a serem observadas são:

*   **Alert Log:** É o "diário de bordo" do banco de dados. Um arquivo de texto que registra todos os eventos importantes, erros (como `ORA-XXXXX`), startups, shutdowns, etc. É o primeiro lugar que um DBA deve olhar quando algo está errado.
*   **Uso de Tablespaces:** É fundamental monitorar o espaço livre nos tablespaces para evitar que eles fiquem cheios, o que causaria erros nas aplicações.
*   **Sessões Ativas:** Verificar quais usuários estão conectados e o que eles estão executando.
*   **Dicionário de Dados (Data Dictionary):** O Oracle mantém um conjunto especial de tabelas e views somente leitura que contêm metadados sobre o banco de dados. Essas views, geralmente com prefixos `DBA_`, `ALL_` e `USER_`, são a principal ferramenta de monitoramento do DBA. Por exemplo, `DBA_TABLESPACES`, `DBA_USERS`, `V$SESSION`.

## Exercícios Práticos - Módulo 2

Vamos colocar em prática os conceitos de administração básica. Use o SQL*Plus ou o SQL Developer, conectado como um usuário com privilégios de DBA (como o `SYSTEM`), para realizar as seguintes tarefas.

### Questões

1.  **Criação de Usuário:** Crie um novo usuário chamado `analista` com a senha `Oracle123`. 
2.  **Concessão de Privilégios:** Conceda ao usuário `analista` os privilégios para se conectar ao banco de dados e para criar tabelas em seu próprio schema.
3.  **Criação de Tablespace:** Crie um novo tablespace chamado `APP_DATA` com um tamanho inicial de 50MB. Escolha um local apropriado para o arquivo de dados (data file), por exemplo, no mesmo diretório dos outros arquivos do seu banco de dados de teste.
4.  **Alteração de Usuário:** Altere o usuário `analista` para que seu tablespace padrão seja o `APP_DATA` que você acabou de criar. Além disso, defina uma cota (quota) de 40MB para ele nesse tablespace, permitindo que ele utilize até 40MB de espaço.
5.  **Criação de Tabela:** Conecte-se ao banco de dados com o usuário `analista`. Crie uma tabela simples chamada `PROJETOS` com as seguintes colunas:
    *   `PROJETO_ID` (NUMBER, Chave Primária)
    *   `NOME_PROJETO` (VARCHAR2(100))
    *   `DATA_INICIO` (DATE)
6.  **Monitoramento de Tablespaces:** Como DBA, escreva uma query na view `DBA_FREE_SPACE` para verificar o espaço livre disponível no tablespace `APP_DATA` após a criação da tabela (mesmo que a tabela esteja vazia, algum espaço mínimo já pode ter sido alocado).
7.  **Monitoramento de Usuários:** Verifique na view `DBA_USERS` a data de criação e o tablespace padrão do usuário `analista`.
8.  **Remoção de Usuário:** Ao final do expediente, o acesso do `analista` não é mais necessário. Remova o usuário `analista` e todos os seus objetos (como a tabela `PROJETOS`).
9.  **Remoção de Tablespace:** Após remover o usuário, o tablespace `APP_DATA` também não é mais necessário. Remova o tablespace e seu arquivo de dados correspondente.

---

### Gabarito dos Exercícios

<details>
<summary>Clique para ver as respostas</summary>

1.  ```sql
    CREATE USER analista IDENTIFIED BY Oracle123;
    ```
2.  ```sql
    GRANT CREATE SESSION, CREATE TABLE TO analista;
    ```
3.  ```sql
    -- O caminho do datafile pode variar dependendo da sua instalação.
    -- Verifique o local dos seus arquivos .dbf existentes para usar um caminho similar.
    CREATE TABLESPACE APP_DATA 
    DATAFILE '/u01/app/oracle/oradata/XE/app_data01.dbf' SIZE 50M;
    ```
4.  ```sql
    ALTER USER analista DEFAULT TABLESPACE APP_DATA QUOTA 40M ON APP_DATA;
    ```
5.  ```sql
    -- Primeiro, conecte-se como o usuário analista.
    -- Em SQL*Plus: CONNECT analista/Oracle123
    -- Em SQL Developer: Crie uma nova conexão para este usuário.
    
    CREATE TABLE PROJETOS (
      PROJETO_ID NUMBER PRIMARY KEY,
      NOME_PROJETO VARCHAR2(100),
      DATA_INICIO DATE
    );
    ```
6.  ```sql
    -- Conectado como DBA (SYSTEM)
    SELECT TABLESPACE_NAME, SUM(BYTES)/1024/1024 AS FREE_MB
    FROM DBA_FREE_SPACE
    WHERE TABLESPACE_NAME = 'APP_DATA'
    GROUP BY TABLESPACE_NAME;
    ```
7.  ```sql
    -- Conectado como DBA (SYSTEM)
    SELECT USERNAME, CREATED, DEFAULT_TABLESPACE
    FROM DBA_USERS
    WHERE USERNAME = 'ANALISTA';
    ```
8.  ```sql
    -- Conectado como DBA (SYSTEM)
    DROP USER analista CASCADE;
    ```
9.  ```sql
    -- Conectado como DBA (SYSTEM)
    DROP TABLESPACE APP_DATA INCLUDING CONTENTS AND DATAFILES;
    ```
</details>


### Visão Detalhada da Arquitetura do DBA

O diagrama a seguir ilustra como os diferentes componentes se interligam do ponto de vista do DBA, incluindo os processos do usuário, listeners e as estruturas de memória e armazenamento.

![Arquitetura DBA Detalhada](https://private-us-east-1.manuscdn.com/sessionFile/YtwaOR8HqwbZ0tIPDb8GQZ/sandbox/FlgnfiUcbySTEyiohickDa-images_1765944434611_na1fn_L2hvbWUvdWJ1bnR1L2N1cnNvX29yYWNsZV9kYmEvYXJxdWl0ZXR1cmFfZGJh.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9wcml2YXRlLXVzLWVhc3QtMS5tYW51c2Nkbi5jb20vc2Vzc2lvbkZpbGUvWXR3YU9SOEhxd2JaMHRJUERiOEdRWi9zYW5kYm94L0ZsZ25maVVjYnlTVEV5aW9oaWNrRGEtaW1hZ2VzXzE3NjU5NDQ0MzQ2MTFfbmExZm5fTDJodmJXVXZkV0oxYm5SMUwyTjFjbk52WDI5eVlXTnNaVjlrWW1FdllYSnhkV2wwWlhSMWNtRmZaR0poLnBuZyIsIkNvbmRpdGlvbiI6eyJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MTc5ODc2MTYwMH19fV19&Key-Pair-Id=K2HSFNDJXOU9YS&Signature=UPtbpj-Hwpc~gLiiTlbbiiR2WHvaJRX4POD10jj~vl56DyQHmVfJaNi7A1IA1S2fZRWIoi2t6zR4nojXMzZN07LgWVjqODjathhzpdKh0IA0~~q3w53y8uXb08Gg9CQ1d3pBqO5mHxQkBKRIgHnwTvsvEsNoWAql7pe7kYctNci~BqT461MJsSAvNvPfEPpMhhAiP0HeeXqYyEVXB~cqv6BWZK0HlkOxRGEAojKcZOkxZmSr9FNLXJRagiV8NuuWi6Ib2Lq23sGm9dCiyOQ0EKugIiDKGFZ5y5-9Gg5a04cP0CMG5IKe434MqVPkxN0WHUZNx3S7Dr7Lb6HTH2iGgg__)
