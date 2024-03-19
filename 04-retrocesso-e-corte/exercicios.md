---
# vim: set spell spelllang=pt_br:
title: Retrocesso e corte
urlcolor: Blue
---

@) [pip 7.9] Três números naturais $A, B, C$ são chamados de terno Pitagórico se $A^2 + B^2 = C^2$. Projete um predicado `terno_pitagorico(A, B, C)`{.prolog} que gere ternos Pitagóricos.

    ```prolog
    ?- terno_pitagorico(A, B, C).
    A = 3,
    B = 4,
    C = 5 ;
    A = 6,
    B = 8,
    C = 10 ;
    A = 5,
    B = 12,
    C = 15 ;
    ...
    ```

@) [pp99 1.26] Defina um predicado `combinacao(K, L, C)`{.prolog} que é verdadeiro se `C`{.prolog} é uma combinação de `K`{.prolog} elementos de `L`{.prolog}. Este predicado deve ser capaz de gerar todas as combinações de `K`{.prolog} elementos via retrocesso. Exemplo

    ```prolog
    ?- combinacao(3, [a, b, c d], C).
    C = [a, b, c] ;
    C = [a, b, d] ;
    C = [a, c, d] ;
    C = [b, c, d] ;
    false.
    ```

@) Defina um predicado `subconjunto(L, S)`{.prolog} que é verdadeiro se `S`{.prolog} é um subconjunto de `L`{.prolog}. Este predicado deve ser capaz de gerar todos os subconjuntos de `L`{.prolog} via retrocesso.
    Exemplo

    ```prolog
    ?- subconjunto([a, b, c], S).
    S = [] ;
    S = [a] ;
    S = [b] ;
    S = [c] ;
    S = [a, b] ;
    S = [a, c] ;
    S = [b, c] ;
    S = [a, b, c] ;
    false.
    ```

@) Dado um conjunto de números inteiros e um inteiro $S$, o problema da soma dos subconjuntos consiste em verificar se existe um subconjunto não vazio cuja soma é $S$. Defina um predicado `soma_subconjunto(A, S, P)`{.prolog} que é verdadeiro se `P`{.prolog} é um subconjunto de `A`{.prolog} e a soma dos elementos de `P`{.prolog} é `S`{.prolog}. Uma estratégia simples (e ingênua) para implementar este predicado é testar os subconjunto até encontrar um que tenha a soma esperada.

    ```prolog
    ?- soma_subconjunto([-7, -3, -2, 5, 8], 0, P).
    P = [-3, -2, 5].
    ```

@) [pip 11-8] Implemente um predicado para encontrar todas as formas de posicionar 4 rainhas em um tabuleiro de xadrez 4x4 de maneira que nenhuma rainha ataque outra. Uma forma de fazer este predicado é criar um gerador de permutações e testar se as rainhas foram posicionadas de maneira correta.

@) Quatro crianças estão visitando o aquário pela primeira vez. Dado os seguintes detalhes

    a) Nem a criança que quer ver o peixe palhaço nem a que quer ver o tubarão levou bolacha.
    b) Quem levou sanduíche é 1 ano mais novo que a criança que quer ver o peixe palhaço.
    c) A criança que levou fruta é 1 ano mais nova do que quem deseja ver o tubarão.
    d) Danilo é 2 anos mais velho do que a criança que levou fruta.
    e) Alan não tem 6 anos.
    f) A criança que levou salgadinho quer ver o tubarão.
    g) Quem deseja ver o tubarão é o Renan ou o menino de 9 anos.
    h) Quem levou sanduíche tem 8 anos ou quer ver o leão-marinho.

    Projete um predicado ` aquario(?C1, ?C2, ?C3, ?C4)`{.prolog}, que é verdadeiro se `C1`{.prolog}, `C2`{.prolog}, `C3`{.prolog} e `C4`{.prolog} são termos `crianca(Nome, Idade, Animal, Lanche)`{.prolog} que atendem as restrições anteriores.


# Referências

- [lpn]. [Lear Prolog Now](http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-html)

- [pip]. Programming in Prolog.

- [pp99]. [99 problemas para resolver em (Prolog)](https://sites.google.com/site/prologsite/prolog-problems)
