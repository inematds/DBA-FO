_**"Este material foi elaborado por um profissional com vasta experiência em administração de bancos de dados Oracle, tendo atuado como DBA por muitos anos, escrito livros e ministrado aulas. O objetivo deste curso é ser autoexplicativo e didático, com exercícios práticos que simulam desafios reais do dia a dia."**_

# Módulo 5: Alta Disponibilidade e Clusters (Avançado)

## Introdução

Para aplicações críticas, onde cada segundo de inatividade representa uma perda significativa, a alta disponibilidade (High Availability - HA) não é um luxo, é uma necessidade. Este módulo aborda as soluções mais avançadas da Oracle para garantir que o banco de dados permaneça operacional mesmo diante de falhas de hardware, software ou desastres. Vamos explorar o Oracle RAC, Data Guard e ASM, as três tecnologias que formam a base da arquitetura de máxima disponibilidade (MAA) da Oracle.

## 5.1. Oracle RAC (Real Application Clusters)

O Oracle RAC é uma tecnologia que permite que múltiplas instâncias Oracle, rodando em servidores diferentes, acessem o mesmo banco de dados (os mesmos data files). Isso proporciona duas vantagens principais:

*   **Alta Disponibilidade:** Se um dos servidores (ou nós do cluster) falhar, as aplicações podem se reconectar automaticamente aos nós sobreviventes, e o serviço de banco de dados continua sem interrupção.
*   **Escalabilidade:** Para aumentar a capacidade de processamento, em vez de trocar o servidor por um mais potente (scale-up), podemos simplesmente adicionar novos nós ao cluster (scale-out).

O coração do RAC é o **Clusterware**, um software que gerencia os nós do cluster, e o **Cache Fusion**, um mecanismo que sincroniza a memória (SGA) de todas as instâncias, garantindo que todas tenham uma visão consistente dos dados.

## 5.2. ASM (Automatic Storage Management)

Gerenciar o armazenamento em um ambiente RAC pode ser complexo. O ASM é a solução da Oracle para isso. O ASM é, ao mesmo tempo, um sistema de arquivos e um gerenciador de volumes lógicos, projetado especificamente para arquivos de banco de dados Oracle.

Em vez de criar data files em sistemas de arquivos como ext4 ou NTFS, o DBA entrega os discos (ou LUNs de um SAN) para o ASM. O ASM então organiza esses discos em **Disk Groups**. A partir daí, o DBA cria os data files dentro desses disk groups, sem precisar se preocupar com o mapeamento físico.

**Vantagens do ASM:**

*   **Gerenciamento Simplificado:** Adicionar ou remover discos se torna uma operação simples de `ALTER DISKGROUP`.
*   **Performance:** O ASM distribui (stripe) os dados uniformemente por todos os discos de um disk group, otimizando a performance de I/O.
*   **Redundância:** O ASM pode espelhar (mirror) os dados entre os discos, protegendo contra falhas de disco. Podemos ter redundância normal (2 vias) ou alta (3 vias).

## 5.3. Oracle Data Guard

Enquanto o RAC protege contra falhas de servidor, o Data Guard protege contra falhas de site (desastres). O Data Guard mantém uma ou mais cópias sincronizadas do banco de dados principal (o **Primary**) em um ou mais bancos de dados de standby (os **Standby**), que podem estar localizados em outro data center, a centenas de quilômetros de distância.

O Data Guard funciona enviando o redo (as alterações) gerado no banco de dados primário para o standby, que então aplica esse redo para se manter atualizado.

Existem diferentes modos de proteção:

*   **Maximum Performance:** Modo assíncrono. A transação é confirmada no primário assim que o redo é escrito no disco local, sem esperar a confirmação do standby. Oferece a melhor performance, mas há um pequeno risco de perda de dados se o primário falhar antes de o redo ser enviado.
*   **Maximum Availability:** Modo síncrono. A transação só é confirmada no primário após o redo ser recebido (mas não necessariamente aplicado) pelo standby. Garante zero perda de dados em caso de falha, com um pequeno impacto na performance.
*   **Maximum Protection:** O mais seguro. A transação só é confirmada após o redo ser escrito e confirmado no standby. Garante zero perda de dados, mas o primário será desligado se não conseguir se comunicar com o standby.

Em caso de desastre no site primário, o DBA pode executar uma operação de **failover**, transformando o banco de dados standby no novo primário em questão de minutos.

## 5.4. Visão Geral da Arquitetura de Máxima Disponibilidade (MAA)

A MAA (Maximum Availability Architecture) não é um produto, mas uma blueprint, um conjunto de melhores práticas da Oracle que combinam RAC, ASM e Data Guard para atingir os mais altos níveis de disponibilidade. Uma configuração típica de MAA envolve:

*   Um **site primário** com um banco de dados RAC rodando sobre ASM.
*   Um **site de recuperação de desastres** com um banco de dados standby (que também pode ser RAC) sendo atualizado pelo Data Guard.

Essa arquitetura protege contra praticamente todos os tipos de falha, desde a falha de um disco até a perda completa de um data center.
_**"Este material foi elaborado por um profissional com vasta experiência em administração de bancos de dados Oracle, tendo atuado como DBA por muitos anos, escrito livros e ministrado aulas. O objetivo deste curso é ser autoexplicativo e didático, com exercícios práticos que simulam desafios reais do dia a dia."**_

# Módulo 5: Alta Disponibilidade e Clusters (Avançado)

## Introdução

Para aplicações críticas, onde cada segundo de inatividade representa uma perda significativa, a alta disponibilidade (High Availability - HA) não é um luxo, é uma necessidade. Este módulo aborda as soluções mais avançadas da Oracle para garantir que o banco de dados permaneça operacional mesmo diante de falhas de hardware, software ou desastres. Vamos explorar o Oracle RAC, Data Guard e ASM, as três tecnologias que formam a base da arquitetura de máxima disponibilidade (MAA) da Oracle.

## 5.1. Oracle RAC (Real Application Clusters)

O Oracle RAC é uma tecnologia que permite que múltiplas instâncias Oracle, rodando em servidores diferentes, acessem o mesmo banco de dados (os mesmos data files). Isso proporciona duas vantagens principais:

*   **Alta Disponibilidade:** Se um dos servidores (ou nós do cluster) falhar, as aplicações podem se reconectar automaticamente aos nós sobreviventes, e o serviço de banco de dados continua sem interrupção.
*   **Escalabilidade:** Para aumentar a capacidade de processamento, em vez de trocar o servidor por um mais potente (scale-up), podemos simplesmente adicionar novos nós ao cluster (scale-out).

O coração do RAC é o **Clusterware**, um software que gerencia os nós do cluster, e o **Cache Fusion**, um mecanismo que sincroniza a memória (SGA) de todas as instâncias, garantindo que todas tenham uma visão consistente dos dados.

## 5.2. ASM (Automatic Storage Management)

Gerenciar o armazenamento em um ambiente RAC pode ser complexo. O ASM é a solução da Oracle para isso. O ASM é, ao mesmo tempo, um sistema de arquivos e um gerenciador de volumes lógicos, projetado especificamente para arquivos de banco de dados Oracle.

Em vez de criar data files em sistemas de arquivos como ext4 ou NTFS, o DBA entrega os discos (ou LUNs de um SAN) para o ASM. O ASM então organiza esses discos em **Disk Groups**. A partir daí, o DBA cria os data files dentro desses disk groups, sem precisar se preocupar com o mapeamento físico.

**Vantagens do ASM:**

*   **Gerenciamento Simplificado:** Adicionar ou remover discos se torna uma operação simples de `ALTER DISKGROUP`.
*   **Performance:** O ASM distribui (stripe) os dados uniformemente por todos os discos de um disk group, otimizando a performance de I/O.
*   **Redundância:** O ASM pode espelhar (mirror) os dados entre os discos, protegendo contra falhas de disco. Podemos ter redundância normal (2 vias) ou alta (3 vias).

## 5.3. Oracle Data Guard

Enquanto o RAC protege contra falhas de servidor, o Data Guard protege contra falhas de site (desastres). O Data Guard mantém uma ou mais cópias sincronizadas do banco de dados principal (o **Primary**) em um ou mais bancos de dados de standby (os **Standby**), que podem estar localizados em outro data center, a centenas de quilômetros de distância.

O Data Guard funciona enviando o redo (as alterações) gerado no banco de dados primário para o standby, que então aplica esse redo para se manter atualizado.

Existem diferentes modos de proteção:

*   **Maximum Performance:** Modo assíncrono. A transação é confirmada no primário assim que o redo é escrito no disco local, sem esperar a confirmação do standby. Oferece a melhor performance, mas há um pequeno risco de perda de dados se o primário falhar antes de o redo ser enviado.
*   **Maximum Availability:** Modo síncrono. A transação só é confirmada no primário após o redo ser recebido (mas não necessariamente aplicado) pelo standby. Garante zero perda de dados em caso de falha, com um pequeno impacto na performance.
*   **Maximum Protection:** O mais seguro. A transação só é confirmada após o redo ser escrito e confirmado no standby. Garante zero perda de dados, mas o primário será desligado se não conseguir se comunicar com o standby.

Em caso de desastre no site primário, o DBA pode executar uma operação de **failover**, transformando o banco de dados standby no novo primário em questão de minutos.

## 5.4. Visão Geral da Arquitetura de Máxima Disponibilidade (MAA)

A MAA (Maximum Availability Architecture) não é um produto, mas uma blueprint, um conjunto de melhores práticas da Oracle que combinam RAC, ASM e Data Guard para atingir os mais altos níveis de disponibilidade. Uma configuração típica de MAA envolve:

*   Um **site primário** com um banco de dados RAC rodando sobre ASM.
*   Um **site de recuperação de desastres** com um banco de dados standby (que também pode ser RAC) sendo atualizado pelo Data Guard.

Essa arquitetura protege contra praticamente todos os tipos de falha, desde a falha de um disco até a perda completa de um data center.
