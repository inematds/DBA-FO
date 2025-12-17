_**"Este material foi elaborado por um profissional com vasta experiência em administração de bancos de dados Oracle, tendo atuado como DBA por muitos anos, escrito livros e ministrado aulas. O objetivo deste curso é ser autoexplicativo e didático, com exercícios práticos que simulam desafios reais do dia a dia."**_

# Módulo 4: Performance e Tuning de Banco de Dados e SQL

## Introdução

Um banco de dados que funciona é bom, mas um banco de dados rápido é essencial. Otimização de desempenho, ou *tuning*, é uma das disciplinas mais desafiadoras e valorizadas de um DBA. Neste módulo, vamos aprender a diagnosticar gargalos de performance, otimizar consultas SQL e ajustar os componentes internos do Oracle para garantir que as aplicações rodem com a máxima eficiência.

## 4.1. Diagnóstico de Performance: Onde Começar?

Quando um usuário reclama que "o sistema está lento", a primeira tarefa do DBA é investigar. O Oracle oferece um conjunto robusto de ferramentas e relatórios para diagnóstico:

*   **AWR (Automatic Workload Repository):** O AWR é um repositório que coleta continuamente estatísticas de desempenho do banco de dados. De hora em hora, por padrão, ele tira um "snapshot" do estado do banco.
*   **Relatório AWR:** Comparando dois snapshots, podemos gerar um relatório AWR, que é um documento HTML extremamente detalhado sobre tudo o que aconteceu no banco de dados naquele intervalo de tempo: as queries SQL mais "caras" (que mais consumiram tempo de CPU, I/O, etc.), os eventos de espera mais significativos, e muito mais. Analisar um relatório AWR é uma habilidade fundamental de um DBA de performance.
*   **ASH (Active Session History):** O ASH amostra a atividade das sessões ativas a cada segundo, permitindo um diagnóstico mais granular de problemas de performance transitórios que podem não aparecer claramente em um relatório AWR de uma hora.
*   **ADDM (Automatic Database Diagnostic Monitor):** O ADDM analisa os dados do AWR e gera recomendações automáticas sobre possíveis problemas de performance, como "Esta query SQL está consumindo 80% do tempo de DB" ou "Considere aumentar o tamanho da SGA".

## 4.2. Tuning de Consultas SQL: O Plano de Execução

Muitas vezes, a causa da lentidão não está no hardware ou na configuração do banco, mas em uma query SQL mal escrita. Para otimizar uma query, precisamos entender como o Oracle a executa. É aqui que entra o **Plano de Execução**.

O Plano de Execução é a "receita" que o Otimizador do Oracle cria para buscar os dados solicitados por uma query. Ele descreve os passos que serão tomados: qual tabela será acessada primeiro, se um índice será usado, como as tabelas serão unidas (join), etc.

O objetivo do DBA é analisar o plano e identificar operações ineficientes, como:

*   **Full Table Scan:** Quando o Oracle lê uma tabela inteira para encontrar poucas linhas. Isso pode ser um sinal de que um índice está faltando ou não está sendo usado.
*   **Tipo de Join Inadequado:** O Oracle pode escolher um método de join (como Nested Loops, Hash Join ou Sort Merge Join) que não é o ideal para o volume de dados em questão.

Para ver o plano de execução, usamos o comando `EXPLAIN PLAN` ou ferramentas gráficas no SQL Developer.

## 4.3. Índices: Acelere suas Consultas

Um índice é uma estrutura de dados separada que "aponta" para as linhas de uma tabela, permitindo que o Oracle encontre dados rapidamente sem ter que ler a tabela inteira. Pense no índice de um livro: em vez de folhear o livro todo para encontrar um tópico, você vai direto ao índice.

*   **Quando criar um índice?** Em colunas que são frequentemente usadas na cláusula `WHERE` de suas queries.
*   **Quando NÃO criar um índice?** Criar índices em excesso pode prejudicar a performance de operações de DML (`INSERT`, `UPDATE`, `DELETE`), pois cada índice também precisa ser atualizado.

```sql
-- Criar um índice na coluna DEPT_ID da tabela EMPREGADOS
CREATE INDEX idx_emp_dept_id ON EMPREGADOS(DEPT_ID);
```

## 4.4. Gestão de Memória e Tuning Interno

Além de otimizar o SQL, um DBA pode ajustar a alocação de memória da instância Oracle para melhorar a performance.

*   **Tuning da SGA:** Aumentar o tamanho do *Buffer Cache* pode reduzir a quantidade de I/O (leitura e escrita em disco), que é uma das operações mais lentas. Se as queries mais frequentes encontrarem seus dados já na memória, a resposta será muito mais rápida. Aumentar o *Shared Pool* pode acelerar o parsing de queries SQL.
*   **Tuning da PGA:** Ajustar a memória disponível para a PGA pode melhorar a performance de operações de ordenação (sorts) e hash joins, evitando que essas operações precisem usar o disco (tablespace temporário).

A partir do Oracle 11g, a **Gestão Automática de Memória (AMM)** simplificou muito esse processo, permitindo que o DBA defina um tamanho total para a memória (`MEMORY_TARGET`) e o Oracle gerencia dinamicamente a divisão entre SGA e PGA.

## 4.5. Ferramentas de Diagnóstico

Além do AWR, o DBA tem outras ferramentas à sua disposição:

*   **SQL Tuning Advisor:** Uma ferramenta que analisa uma query SQL de alta carga e fornece recomendações específicas, como criar um novo índice, coletar estatísticas ou reescrever a query de uma forma mais eficiente.
*   **SQL Trace e TKPROF:** Para uma análise extremamente detalhada, podemos habilitar o "trace" de uma sessão. Isso gera um arquivo de trace que contém informações sobre cada passo da execução de uma query. A ferramenta `TKPROF` formata esse arquivo em um relatório legível, mostrando o plano de execução, tempos de CPU, I/O, etc.

## Exercícios Práticos - Módulo 4

Performance e Tuning é uma área que exige muita prática. Os exercícios a seguir são projetados para simular problemas comuns de desempenho. Você precisará de um schema com um volume de dados razoável para ver os efeitos do tuning (o schema de exemplo `HR` que vem com o Oracle é um bom começo).

### Questões

1.  **Identificando uma Query Lenta:** A query a seguir está sendo executada em um ambiente com milhões de empregados e é considerada lenta. Sua tarefa é obter o plano de execução para ela. O que você suspeita que seja a operação mais custosa?

    ```sql
    SELECT * 
    FROM HR.EMPLOYEES 
    WHERE LAST_NAME = 'Smith';
    ```

2.  **Criando um Índice:** Com base na sua análise da query anterior, crie um índice que possa acelerar essa consulta. Após criar o índice, gere o plano de execução novamente. O que mudou?

3.  **Coletando Estatísticas:** O Otimizador do Oracle depende de estatísticas sobre os dados (quantas linhas, distribuição dos valores, etc.) para tomar boas decisões. Se as estatísticas estiverem desatualizadas, o plano de execução pode ser ruim. Execute o comando para coletar estatísticas novas para a tabela `HR.EMPLOYEES`.

4.  **Analisando um Join:** A query abaixo junta duas tabelas. Obtenha o plano de execução. Identifique o método de join que o Oracle escolheu (Nested Loops, Hash Join, etc.) e as operações de acesso a cada tabela (Full Table Scan, Index Scan, etc.).

    ```sql
    SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME
    FROM HR.EMPLOYEES e
    JOIN HR.DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
    WHERE d.DEPARTMENT_NAME = 'Sales';
    ```

5.  **Gerando um Relatório AWR:** Se você tiver acesso a um ambiente com o Diagnostic Pack licenciado (geralmente edições Enterprise), gere um relatório AWR para o intervalo da última hora. Para fazer isso, você precisa encontrar dois Snap IDs consecutivos e usar o script `awrrpt.sql`.

    *   Primeiro, encontre os Snap IDs: `SELECT SNAP_ID, BEGIN_INTERVAL_TIME FROM DBA_HIST_SNAPSHOT ORDER BY SNAP_ID DESC;`
    *   Depois, execute o script no SQL*Plus: `@$ORACLE_HOME/rdbms/admin/awrrpt.sql`
    *   O script pedirá o formato (HTML ou text), o Snap ID inicial e o Snap ID final. Abra o relatório gerado e tente identificar a seção "SQL ordered by Elapsed Time".

---

### Gabarito dos Exercícios

<details>
<summary>Clique para ver as respostas</summary>

1.  ```sql
    -- No SQL*Plus ou SQL Developer, execute:
    EXPLAIN PLAN FOR
    SELECT * 
    FROM HR.EMPLOYEES 
    WHERE LAST_NAME = 'Smith';

    -- Em seguida, para ver o plano:
    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
    ```
    
    **Análise:** Sem um índice na coluna `LAST_NAME`, o plano de execução muito provavelmente mostrará uma operação de `TABLE ACCESS FULL` na tabela `EMPLOYEES`. Esta é a operação mais custosa, pois força o Oracle a ler todas as linhas da tabela.

2.  ```sql
    -- Criar o índice
    CREATE INDEX idx_emp_last_name ON HR.EMPLOYEES(LAST_NAME);

    -- Gerar o plano novamente
    EXPLAIN PLAN FOR
    SELECT * 
    FROM HR.EMPLOYEES 
    WHERE LAST_NAME = 'Smith';

    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
    ```

    **Análise:** O novo plano de execução deve mostrar uma mudança significativa. Em vez do `TABLE ACCESS FULL`, você provavelmente verá um `INDEX RANGE SCAN` no índice `IDX_EMP_LAST_NAME`, seguido por um `TABLE ACCESS BY INDEX ROWID`. Isso é muito mais eficiente, pois o Oracle usa o índice para encontrar rapidamente as linhas desejadas e depois busca apenas essas linhas na tabela.

3.  ```sql
    -- Coletar estatísticas para a tabela
    EXEC DBMS_STATS.GATHER_TABLE_STATS('HR', 'EMPLOYEES');
    ```

4.  ```sql
    EXPLAIN PLAN FOR
    SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME
    FROM HR.EMPLOYEES e
    JOIN HR.DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
    WHERE d.DEPARTMENT_NAME = 'Sales';

    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
    ```

    **Análise:** O plano exato pode variar, mas um plano eficiente aqui provavelmente envolveria:
    *   Um `INDEX UNIQUE SCAN` na chave primária da tabela `DEPARTMENTS` (usando o valor 'Sales' se houver um índice na coluna `DEPARTMENT_NAME`).
    *   Um `INDEX RANGE SCAN` no índice da chave estrangeira `DEPARTMENT_ID` na tabela `EMPLOYEES`.
    *   Um método de join como `NESTED LOOPS`, que é eficiente quando uma das tabelas retorna poucas linhas (neste caso, a tabela `DEPARTMENTS` filtrada por 'Sales').

5.  A execução deste exercício é interativa e depende do seu ambiente. O passo a passo fornecido na questão é o caminho correto. O principal objetivo é se familiarizar com o processo de geração e a estrutura de um relatório AWR, que é a ferramenta de diagnóstico mais importante para um DBA de performance.

</details>
