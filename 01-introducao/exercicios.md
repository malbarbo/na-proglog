---
# vim: set spell spelllang=pt_br:
title: Introdução
---

**Atenção**: Nos exercícios que pedem a resposta do Prolog a uma dada consulta, é interessante fazer o exercício simulando a execução antes de testar com o Prolog. Fazendo isto você exercitará o entendimento do funcionamento do Prolog.

#.  [pip 1.2] Dado a seguinte base de conhecimento

    ```prolog
    homem(albert).
    homem(edward).

    mulher(alice).
    mulher(victoria).

    % o primeiro argumento é o(a) filho(a),
    % o segundo argumento a mãe e o terceiro o pai
    pais(edward, victoria, albert).
    pais(alice, victoria, albert).

    irma_de(X, Y) :-
        mulher(X),
        pais(X, M, F),
        pais(Y, M, F).
    ```

    como o Prolog responde a consulta `irma_de(alice, X).`

#.  [lpn 1.5] Dado a seguinte base de conhecimento

    ```prolog
    bruxo(rony).
    bruxo(X) :- temVassoura(X), temVarinha(X).
    temVarinha(harry).
    jogadorQuadribol(harry).
    temVassoura(X) :- jogadorQuadribol(X).
    ```

    como o Prolog responde as seguintes consultas?

    ```prolog
    bruxo(rony).
    bruxa(rony).
    bruxo(hermione).
    bruxa(hermione).
    bruxo(harry).
    bruxo(Y).
    bruxa(Y).
    ```

#.  [lpn 1.5] Dado a seguinte base de conhecimento

    ```prolog
    likes(sam,Food) :- indian(Food), mild(Food).
    likes(sam,Food) :- chinese(Food).
    likes(sam,Food) :- italian(Food).
    likes(sam,chips).

    indian(curry).
    indian(dahl).
    indian(tandoori).
    indian(kurma).

    mild(dahl).
    mild(tandoori).
    mild(kurma).

    chinese(chow_mein).
    chinese(chop_suey).
    chinese(sweet_and_sour).

    italian(pizza).
    italian(spaghetti).
    ```

    como o Prolog responde as seguintes consultas?

    ```prolog
    likes(sam,dahl).
    likes(sam,chop_suey).
    likes(sam,pizza).
    likes(sam,chips).
    likes(sam,curry).
    ```



# Referências

-   [lpn]. [Lear Prolog Now](http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-html)

-   [pip]. Programming in Prolog.
