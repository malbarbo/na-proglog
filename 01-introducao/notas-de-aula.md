---
title: Introdução
template: slide.tex
---

# Introdução

### Introdução

No paradigma de **programação declarativo**, as estruturas e os elementos do
programa são escritos de maneira a especificar a lógica da computação sem
descrever o fluxo de controle.

Consequência da transparência referencial.


# Imperativo vs declarativo

### Imperativo vs declarativo

-   Imperativo

    -   Modelo de computação baseado em sequência passo a passo de comandos

    -   Atribuições destrutivas

    -   Ordem de execução é crucial, os comandos só podem ser entendidos no
        contexto das computações anteriores devido aos efeitos colaterais

    -   Controle é responsabilidade do programados

    -   Exemplos: Java, C, Pascal

### Imperativo vs declarativo

-   Declarativo

    -   Modelo de computação baseado em um sistema onde as relações são
        especificadas diretamente em termos da entrada

    -   Atribuição não destrutiva

    -   A ordem de execução não importa (não tem efeitos colaterais)

    -   O programador não é responsável pelo controle

    -   Exemplos: SQL, Prolog, Haskell

-   Alguns autores consideram "como" (imperativo) vs "o que" (declarativo)


# Funcional vs lógico

### Funcional vs lógico

-   Os dois principais paradigmas declarativos são o funcional e o lógico

-   Funcional

    -   Baseado em declaração e aplicação de funções (cálculo lambda)

    -   Todos os parâmetro de uma função precisam estar instanciados

    -   Clara distinção entre entrada e saída

-   Lógico

    -   Baseado no cálculo de predicados

    -   Objetos e relações

    -   A computação é feita usando um mecanismo de inferência lógico

    -   A computação pode ser realizada com variáveis não instanciadas


# Prolog

### Prolog

- Para estudar o paradigma lógico vamos utilizar a linguagem Prolog

- Existem muitas implementações

- Vamos utilizar o [SWI-Prolog](http://www.swi-prolog.org)


## Primeiros passos

### Instalação e execução

- Instalação

    ```console
    $ apt-get install swi-prolog
    ```

- Execução

    ```console
    $ swipl
    ```

### Edição e consulta com editor integrado

![](swipl-terminal)

### Editor integrado

![](swipl-editor)


### Edição e consulta com outro editor

-   Editar o arquivo usando o editor de sua preferência

-   Ler o arquivo no swipl

    ```prolog
    ?- consult('arquivo.pl').
    ```

-   Fazer consultas

    ```prolog
    ?- editor(joao, E).
    E = emacs.
    ```

-   Depois de alterar o arquivo, ele deve ser lido novamente


### Leitura recomendada

-   [The principal programming paradigms](http://www.info.ucl.ac.be/~pvr/paradigmsDIAGRAMeng108.pdf)

-   [Declarative programming](https://en.wikipedia.org/wiki/Declarative_programming)

-   [Logic programming](https://en.wikipedia.org/wiki/Logic_programming)

-   [Prolog](https://en.wikipedia.org/wiki/Prolog)
