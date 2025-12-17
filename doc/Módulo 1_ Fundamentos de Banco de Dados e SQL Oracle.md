_**"Este material foi elaborado por um profissional com vasta experiência em administração de bancos de dados Oracle, tendo atuado como DBA por muitos anos, escrito livros e ministrado aulas. O objetivo deste curso é ser autoexplicativo e didático, com exercícios práticos que simulam desafios reais do dia a dia."**_

# Módulo 1: Fundamentos de Banco de Dados e SQL Oracle

## Introdução

Bem-vindo ao início de sua jornada para se tornar um Administrador de Banco de Dados (DBA) Oracle. Este primeiro módulo é a base de todo o conhecimento que você irá adquirir. Aqui, vamos explorar os conceitos essenciais que sustentam os bancos de dados relacionais e aprender a linguagem fundamental para interagir com eles: o SQL.

## 1.1. Conceitos de Banco de Dados Relacional

Um **banco de dados relacional** é um sistema que organiza os dados em tabelas. Pense em uma tabela como uma planilha, com linhas e colunas. Cada linha representa um registro (por exemplo, um cliente) e cada coluna representa um atributo desse registro (por exemplo, nome, email, telefone).

Os principais conceitos que você precisa dominar são:

*   **Tabela (Table):** A estrutura fundamental de armazenamento, composta por linhas e colunas.
*   **Coluna (Column):** Um atributo específico de uma tabela. Possui um nome e um tipo de dado (texto, número, data, etc.).
*   **Linha (Row):** Um registro único dentro de uma tabela.
*   **Chave Primária (Primary Key):** Uma ou mais colunas que identificam unicamente cada linha em uma tabela. Não pode haver duas linhas com a mesma chave primária.
*   **Chave Estrangeira (Foreign Key):** Uma coluna (ou conjunto de colunas) em uma tabela que se refere à chave primária de outra tabela. É o que cria o "relacionamento" entre as tabelas.

## 1.2. Modelagem de Dados (Entidade-Relacionamento)

![Diagrama Entidade-Relacionamento](https://private-us-east-1.manuscdn.com/sessionFile/YtwaOR8HqwbZ0tIPDb8GQZ/sandbox/FlgnfiUcbySTEyiohickDa-images_1765944434770_na1fn_L2hvbWUvdWJ1bnR1L2N1cnNvX29yYWNsZV9kYmEvZGlhZ3JhbWFfZXI.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9wcml2YXRlLXVzLWVhc3QtMS5tYW51c2Nkbi5jb20vc2Vzc2lvbkZpbGUvWXR3YU9SOEhxd2JaMHRJUERiOEdRWi9zYW5kYm94L0ZsZ25maVVjYnlTVEV5aW9oaWNrRGEtaW1hZ2VzXzE3NjU5NDQ0MzQ3NzBfbmExZm5fTDJodmJXVXZkV0oxYm5SMUwyTjFjbk52WDI5eVlXTnNaVjlrWW1FdlpHbGhaM0poYldGZlpYSS5wbmciLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE3OTg3NjE2MDB9fX1dfQ__&Key-Pair-Id=K2HSFNDJXOU9YS&Signature=X7qOTVbkyNdgWRWkNKvt2RKOsnDStGM2pYDxSG7el111BEkfMyjOGvjBKMdWAWa0E7WiO8J7iaoHNpF1j7Dz4Q7HBQ9tQehKtDDyTBMW1kJiRKlD2GFiXRjNI5rZCPbXUJAac~UK2NXb-YmzJe-nGXTIKcHq3u~jI96BmQ3qLYXPCQrF1~ghsNSDTffuN5Na1hz7VuiRd5WDvTmwhso2ujiXTIw6ReMCLjctNSj7KhpmFXYrUdrlgQSQwVtrwilFUAvIm4~8rjc-wj-B8~gFqFovpuPT0JMmAVsHY8mQJpcbuh9aYv0ZYwq7oQO8RK~TWNdRLNjk8D27NBZlTMCB~A__)

A modelagem de dados é o processo de criar um diagrama que representa a estrutura do banco de dados. O modelo mais comum é o **Diagrama Entidade-Relacionamento (DER)**.

*   **Entidade:** Representa um objeto do mundo real sobre o qual queremos armazenar informações (ex: `CLIENTES`, `PRODUTOS`, `PEDIDOS`). No banco de dados, uma entidade se torna uma tabela.
*   **Atributo:** Uma característica de uma entidade (ex: `nome` do cliente, `preco` do produto). Atributos se tornam colunas.
*   **Relacionamento:** A associação entre duas ou mais entidades (ex: um `CLIENTE` faz um `PEDIDO`). Relacionamentos são implementados usando chaves estrangeiras.

## 1.3. O Ambiente Oracle: SQL Developer e SQL*Plus

Para interagir com o banco de dados Oracle, utilizamos ferramentas cliente. As duas mais importantes para um DBA são:

*   **SQL Developer:** Uma interface gráfica (GUI) completa e gratuita da Oracle. Permite escrever e executar queries SQL, administrar objetos do banco, importar/exportar dados e muito mais. É a ferramenta ideal para o dia a dia.
*   **SQL*Plus:** Uma ferramenta de linha de comando (CLI). Embora menos "amigável", é extremamente poderosa para automação, execução de scripts e tarefas administrativas que não exigem uma interface gráfica. Todo DBA precisa saber usar o SQL*Plus.

## 1.4. A Linguagem SQL: A Base de Tudo

SQL (Structured Query Language) é a linguagem padrão para gerenciar e manipular bancos de dados relacionais. Ela é dividida em subconjuntos de comandos. Os mais importantes para começar são:

*   **DQL (Data Query Language):** Para fazer consultas. O principal comando é o `SELECT`.
*   **DML (Data Manipulation Language):** Para manipular os dados. Inclui os comandos `INSERT` (inserir), `UPDATE` (atualizar) e `DELETE` (apagar).
*   **DDL (Data Definition Language):** Para definir a estrutura do banco. Inclui `CREATE` (criar tabelas, etc.), `ALTER` (alterar) e `DROP` (remover).
*   **DCL (Data Control Language):** Para controlar o acesso aos dados. Inclui `GRANT` (conceder permissões) e `REVOKE` (revogar permissões).

Nos próximos tópicos, vamos mergulhar em cada um desses comandos com exemplos práticos.

## 1.5. Comandos SQL na Prática

Vamos agora praticar os comandos SQL essenciais. Para nossos exemplos, vamos imaginar duas tabelas simples: `DEPARTAMENTOS` e `EMPREGADOS`.

**Tabela: DEPARTAMENTOS**
| DEPT_ID (PK) | NOME_DEP      |
|--------------|---------------|
| 10           | 'FINANCEIRO'  |
| 20           | 'TI'          |
| 30           | 'RH'          |

**Tabela: EMPREGADOS**
| EMP_ID (PK) | NOME_EMP      | SALARIO | DEPT_ID (FK) |
|-------------|---------------|---------|--------------|
| 101         | 'JOÃO SILVA'  | 5000    | 10           |
| 102         | 'ANA LIMA'    | 7000    | 20           |
| 103         | 'CARLOS SOUZA'| 6500    | 20           |
| 104         | 'MARIA GOMES' | 4000    | 10           |

### SELECT: Consultando Dados

O comando `SELECT` é usado para buscar dados. A sintaxe básica é `SELECT colunas FROM tabela WHERE condicao`.

```sql
-- Selecionar todos os empregados
SELECT * FROM EMPREGADOS;

-- Selecionar o nome e o salário dos empregados do departamento de TI (DEPT_ID = 20)
SELECT NOME_EMP, SALARIO FROM EMPREGADOS WHERE DEPT_ID = 20;
```

### INSERT: Inserindo Novos Dados

O `INSERT` adiciona novas linhas a uma tabela.

```sql
-- Inserir um novo departamento
INSERT INTO DEPARTAMENTOS (DEPT_ID, NOME_DEP) VALUES (40, 'VENDAS');

-- Inserir um novo empregado
INSERT INTO EMPREGADOS (EMP_ID, NOME_EMP, SALARIO, DEPT_ID) VALUES (105, 'PEDRO COSTA', 5500, 40);
```

### UPDATE: Atualizando Dados Existentes

O `UPDATE` modifica registros que já existem na tabela.

```sql
-- Aumentar o salário de todos os empregados do departamento Financeiro em 10%
UPDATE EMPREGADOS
SET SALARIO = SALARIO * 1.10
WHERE DEPT_ID = 10;
```

### DELETE: Removendo Dados

O `DELETE` apaga linhas de uma tabela. **Cuidado:** use sempre a cláusula `WHERE` para não apagar todos os dados!

```sql
-- Remover o empregado com ID 105
DELETE FROM EMPREGADOS WHERE EMP_ID = 105;
```

## 1.6. Joins, Funções e Subqueries

### Joins: Combinando Tabelas

O `JOIN` é uma das operações mais poderosas do SQL. Ele permite combinar linhas de duas ou mais tabelas com base em uma coluna relacionada.

```sql
-- Selecionar o nome de cada empregado e o nome do seu respectivo departamento
SELECT E.NOME_EMP, D.NOME_DEP
FROM EMPREGADOS E
JOIN DEPARTAMENTOS D ON E.DEPT_ID = D.DEPT_ID;
```

### Funções: Manipulando Dados

O Oracle oferece uma vasta biblioteca de funções para manipular texto, números e datas. Elas podem ser usadas diretamente no seu `SELECT`.

*   **Funções de Agregação:** `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`.
*   **Funções de String:** `UPPER()`, `LOWER()`, `SUBSTR()`.
*   **Funções Numéricas:** `ROUND()`, `TRUNC()`.

```sql
-- Contar quantos empregados existem em cada departamento
SELECT DEPT_ID, COUNT(*) AS TOTAL_EMPREGADOS
FROM EMPREGADOS
GROUP BY DEPT_ID;
```

### Subqueries: Consultas Aninhadas

Uma subquery (ou subconsulta) é uma consulta `SELECT` dentro de outra consulta. Elas são úteis para realizar filtros complexos.

```sql
-- Encontrar os empregados que ganham mais que a média salarial de toda a empresa
SELECT NOME_EMP, SALARIO
FROM EMPREGADOS
WHERE SALARIO > (SELECT AVG(SALARIO) FROM EMPREGADOS);
```

## Exercícios Práticos - Módulo 1

Agora é sua vez de praticar! Tente resolver os seguintes exercícios usando o SQL Developer ou SQL*Plus. As respostas estão no final desta seção.

**Cenário:** Você foi contratado como DBA júnior de uma pequena livraria. O banco de dados possui as seguintes tabelas:

**Tabela: AUTORES**
| AUTOR_ID (PK) | NOME_AUTOR      | PAIS_ORIGEM   |
|---------------|-----------------|---------------|
| 1             | 'J.K. Rowling'  | 'Reino Unido' |
| 2             | 'George Orwell' | 'Reino Unido' |
| 3             | 'Machado de Assis'| 'Brasil'      |

**Tabela: LIVROS**
| LIVRO_ID (PK) | TITULO                | ANO_PUBLICACAO | PRECO | AUTOR_ID (FK) |
|---------------|-----------------------|----------------|-------|---------------|
| 101           | 'Harry Potter e a Pedra Filosofal' | 1997           | 35.00 | 1             |
| 102           | '1984'                | 1949           | 28.50 | 2             |
| 103           | 'Dom Casmurro'        | 1899           | 22.00 | 3             |
| 104           | 'A Revolução dos Bichos'| 1945           | 25.00 | 2             |

### Questões

1.  **SELECT Básico:** Escreva uma query para selecionar o título e o ano de publicação de todos os livros.
2.  **SELECT com WHERE:** Escreva uma query para encontrar todos os livros publicados antes de 1950.
3.  **INSERT:** Insira um novo autor na tabela `AUTORES`: ID `4`, Nome `'J.R.R. Tolkien'`, País `'África do Sul'`. 
4.  **INSERT:** Insira um novo livro para o autor recém-criado: ID `105`, Título `'O Hobbit'`, Ano `1937`, Preço `45.00`, ID do Autor `4`.
5.  **UPDATE:** O preço do livro '1984' subiu. Atualize seu preço para `32.75`.
6.  **DELETE:** O livro 'O Hobbit' foi removido do catálogo. Escreva o comando para apagá-lo da tabela `LIVROS`.
7.  **JOIN:** Escreva uma query que mostre o título de cada livro e o nome do seu respectivo autor.
8.  **Função de Agregação:** Escreva uma query para calcular o preço médio de todos os livros.
9.  **Subquery:** Encontre o título dos livros que são mais caros que a média de todos os preços.
10. **JOIN com WHERE:** Liste os títulos dos livros escritos por autores do 'Reino Unido'.

---

### Gabarito dos Exercícios

<details>
<summary>Clique para ver as respostas</summary>

1.  ```sql
    SELECT TITULO, ANO_PUBLICACAO FROM LIVROS;
    ```
2.  ```sql
    SELECT * FROM LIVROS WHERE ANO_PUBLICACAO < 1950;
    ```
3.  ```sql
    INSERT INTO AUTORES (AUTOR_ID, NOME_AUTOR, PAIS_ORIGEM) VALUES (4, 'J.R.R. Tolkien', 'África do Sul');
    ```
4.  ```sql
    INSERT INTO LIVROS (LIVRO_ID, TITULO, ANO_PUBLICACAO, PRECO, AUTOR_ID) VALUES (105, 'O Hobbit', 1937, 45.00, 4);
    ```
5.  ```sql
    UPDATE LIVROS SET PRECO = 32.75 WHERE TITULO = '1984';
    ```
6.  ```sql
    DELETE FROM LIVROS WHERE TITULO = 'O Hobbit';
    ```
7.  ```sql
    SELECT L.TITULO, A.NOME_AUTOR
    FROM LIVROS L
    JOIN AUTORES A ON L.AUTOR_ID = A.AUTOR_ID;
    ```
8.  ```sql
    SELECT AVG(PRECO) AS PRECO_MEDIO FROM LIVROS;
    ```
9.  ```sql
    SELECT TITULO, PRECO
    FROM LIVROS
    WHERE PRECO > (SELECT AVG(PRECO) FROM LIVROS);
    ```
10. ```sql
    SELECT L.TITULO
    FROM LIVROS L
    JOIN AUTORES A ON L.AUTOR_ID = A.AUTOR_ID
    WHERE A.PAIS_ORIGEM = 'Reino Unido';
    ```
</details>
