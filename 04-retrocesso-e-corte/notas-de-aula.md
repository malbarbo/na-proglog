---
# vim: set spell spelllang=pt_br sw=4:
title: Retrocesso e corte
---


Retrocesso
==========

## Retrocesso

Retrocesso é basicamente uma forma de busca

\pause

Suponha que o Prolog está tentado satisfazer a sequência de metas $m_1, m_2$.
Quando o Prolog encontra um conjunto de unificações de variáveis que tornam
a meta $m_1$ verdadeira, ele se compromete com estas unificações e tentar
satisfazer a meta $m_2$. Em seguida duas coisas podem acontecer:


## Retrocesso

A meta $m_2$ é satisfeita com um conjunto de unificações. O usuário pode pedir
para o Prolog buscar soluções alternativas. Neste caso o Prolog desfaz
o conjunto de unificações e tenta encontrar um outro conjunto de unificações
que torne $m_2$ verdadeiro, se não for possível, o Prolog retrocede para $m_1$,
desfaz as unificações para esta meta e tenta satisfazer $m_1$ novamente obtendo
um (novo) conjunto de unificações

\pause

A meta $m_2$ não é satisfeita. Nesta casso o Prolog retrocede para a $m_1$,
desfaz as unificações para esta meta e tenta satisfazer $m_1$ novamente obtendo
um (novo) conjunto de unificações


## Retrocesso

Retrocesso pode ocorrer para buscar soluções extras para o conjunto de metas ou
para buscar a primeira solução quando um comprometimento com conjunto de
unificações não levou a uma solução


## Retrocesso

Dado o programa a seguir, qual o resultado produzido na consulta
`possivel_par(X, Y)` se o usuário pressionar `;` após cada resposta?

\small

```prolog
possivel_par(ana, pedro).

possivel_par(X, Y) :-
    mulher(X),
    homem(Y).

mulher(claudia).
mulher(marcia).
mulher(elsa).

homem(joao).
homem(paulo).
```


## Retrocesso

\small

```prolog
?- possivel_par(X, Y).
X = ana,
Y = pedro ;
X = claudia,
Y = joao ;
X = claudia,
Y = paulo ;
X = marcia,
Y = joao ;
X = marcia,
Y = paulo ;
X = elsa,
Y = joao ;
X = elsa,
Y = paulo.
```


## Retrocesso

A maioria dos predicados pré-definidos do Prolog quando usados em metas com
(várias) variáveis podem produzir mais do que uma reposta

```prolog
?- member(3, [1, 3, 2, 4]).
true ;
false.
?- member(X, [1, 3, 2, 4]).
X = 1 ;
X = 3 ;
X = 2 ;
X = 4.
```


## Retrocesso

```prolog
?- between(1, 4, X).
X = 1 ;
X = 2 ;
X = 3 ;
X = 4.

?- between(3, inf, X).
X = 3 ;
X = 4 ;
X = 5 ;
X = 6 ;
...
```


## Retrocesso

```prolog
?- select(X, [a, b, c], R).
X = a,
R = [b, c] ;
X = b,
R = [a, c] ;
X = c,
R = [a, b] ;
false.

?- select(d, L, [a, b, c]).
L = [d, a, b, c] ;
L = [a, d, b, c] ;
L = [a, b, d, c] ;
L = [a, b, c, d] ;
```


## Retrocesso

```prolog
?- permutation([a, b, c], P).
P = [a, b, c] ;
P = [a, c, b] ;
P = [b, a, c] ;
P = [b, c, a] ;
P = [c, a, b] ;
P = [c, b, a] ;
false.
```


## Retrocesso

```prolog
?- nth0(X, [a, b, c], E).
X = 0,
E = a ;
X = 1,
E = b ;
X = 2,
E = c.
```


## Retrocesso

```prolog
?- append(X, Y, [1, 2, 3]).
X = [],
Y = [1, 2, 3] ;
X = [1],
Y = [2, 3] ;
X = [1, 2],
Y = [3] ;
X = [1, 2, 3],
Y = [] ;
false.
```


## Retrocesso

```prolog
?- prefix(A, [1, 2, 3]).
A = [] ;
A = [1] ;
A = [1, 2] ;
A = [1, 2, 3] ;
false.
```


## Exemplo - selecionado

Projete um predicado `selecionado(?N, ?L, ?R)`{.prolog} que é verdadeiro se
a lista `R`{.prolog} é como a lista `L`{.prolog}  mas sem o elemento
`N`{.prolog}. (Mesmo comportamento do predicado pré-definido
`select/3`{.prolog}).


## Exemplo - permutação

Projete um predicado `permutacao(+L, ?P)`{.prolog}  que é verdadeiro se a lista
`P`{.prolog}  é uma permutação da lista `L`{.prolog} . (Mesmo comportamento do
predicado pré-definido `permutation/2`{.prolog} ).



Geradores
=========


## Geradores

Predicados que produzem mais de uma resposta podem ser chamados de gerados

\pause

As vezes é interessante ter predicados que possam ser satisfeitos infinitas
vezes, gerando um conjunto de unificações a cada vez. Isto é particularmente
interessante na estratégia gerar e testar


## Exemplo - natural

Projete um predicado `natural(?N)`{.prolog} que é verdadeiro se `N`{.prolog}
é um número natural. Se `N`{.prolog}  não estiver instanciado, o predicado deve
gerar números naturais.



Corte
=====


## Corte

As vezes é necessário interromper o processo de retrocesso. Para isso
utilizamos o operador de corte

\pause

A meta corte é especificada com o predicado `!`{.prolog}

\pause

Quando a meta `!`{.prolog}  é encontrada ela é satisfeita imediatamente mas não
pode ser ressatisfeita, isto é, quando um corte é encontrado como uma meta,
o sistema compromete-se com todas as escolhas feitas deste que meta pai foi
invocada. Todas as outras alternativas são descartadas. Ou seja, um tentativa
de ressatisfação feita em uma meta entre a meta pai e a meta corte irá falhar


## Corte

No exemplo abaixo o Prolog irá fazer o retrocesso entre as metas $a, b, c$ até
que a meta $c$ seja satisfeita. Quando a meta $c$ for satisfeita a meta corte
será satisfeita em seguida. Deste momento em diante o retrocesso pode acontecer
entre as metas $d, e, f$, mas uma vez que a meta $d$ não possa mais ser
satisfeita, o Prolog não retrocede para tentar ressatisfazer as metas $a, b$
e $c$, e portanto a meta $m$ irá falhar (possivelmente depois de ser satisfeita
várias vezes)

```prolog
m :- a, b, c, !, d, e, f.
```


## Corte

Existem alguns usos comuns para o corte, entre eles estão: \pause

- Confirmação de escolha \pause

- Junto com o predicado `fail`{.prolog} para falhar imediatamente \pause

- Na estratégia gerar e testar


## Confirmação de escolha

Até o momento usamos o operador de corte para confirmar uma escolha, ou seja,
para informar para o Prolog que ele não precisa buscar respostas alternativas

\pause

Este uso ocorre comumente quando queremos que um predicado se parece com uma
função (veja os exemplos de dados compostos que utilizam corte).


## Confirmação de escolha

Nestes casos o corte é apenas uma otimização, sendo possível escrever
o predicado com a mesma semântica sem utilizar o corte. Considere o exemplo
onde exista duas escolhas excludentes para um determinado predicado que depende
de uma determinada condição

```prolog
a :- b, c.
a :- \+b, d.
```

\pause

O Prolog pode tentar satisfazer a meta `b`{.prolog} duas vezes. Isto pode ser
ineficiente se a satisfação de `b`{.prolog} for custosa. Neste caso, o uso do
corte pode tornar o predicado mais eficiente

```prolog
a :- b, !, c.
a :- d.
```


## Combinação com `fail`{.prolog}

As vezes é necessário dizer ao Prolog para falhar imediadamente uma meta
específica sem ter que tentar soluções alternativas

\pause

Por exemplo, suponha que uma determinada meta possa ser satisfeita de várias
maneiras, mas é possível identificar condições que a meta deve falhar (sem ter
que tentar estas muitas maneiras). Então é possível combinar o corte com
o predicado `fail`{.prolog} para evitar que estas muitas maneiras sejam verificadas


## Exemplo - aprovado

Projete  um predicado `aprovado(A)`{.prolog} que é verdadeiro se o aluno
`A`{.prolog} foi aprovado. Um aluno pode ser aprovado se ele obteve média maior
ou igual a 6 ou se a após o exame ele obteve média maior ou igual a 5. Em ambos
os casos ele deve ter pelo menos 75% de presença.


## Implementação de falha e negação

Como implementar o predicado `fail`{.prolog}? \pause

```prolog
fail :- 0 = 1.
```

\pause

Como implementar o operador de negação? \pause

```prolog
\+(P) :- call(P), !, fail.
\+(P).
```


## Gerar e testar

Uma estratégia comum utilizada em programas Prolog envolve a geração de
diversas possíveis soluções (via retrocesso) para um determinado problema
seguido do teste para validar a solução. Após encontrar a solução
o processo é interrompido com o operador de corte.


## Exemplo - ordenação

Use a estratégia gerar e projete um predicado `ordenacao(L, S)`{.prolog} que é
verdadeiro se `S`{.prolog} é a lista `L`{.prolog} com os elementos ordenados.


## Exemplo - caminho hamiltoniano

Projete um predicado `caminho_hamiltoniano(+G, -C)`{.prolog} que é verdadeiro se
`C`{.prolog} é um caminho hamiltoniano (lista de vértices) do grafo
`G`{.prolog}. Um caminho hamiltoniano é um caminho que passa exatamente uma vez
por cada vértice de `G`{.prolog}. Use a estratégia gerar e testar, gere
permutações dos vértices e verifique se forma um caminho.


## Exemplo - primeiro primo

Projete um predicado `primeiro_primo(+N, ?P)`{.prolog} que é verdadeiro se
`P`{.prolog} é o primeiro primo maior que ou igual a `N`{.prolog}. Use
a estratégia gerar e testar, gere números inteiros a partir de `N`{.prolog}
e teste se ele é primo.



Referências
===========


## Referências

- Capítulo 4 do livro Programming in Prolog

- Capítulo 5 da apostila [Paradigmas de programação - Prolog](http://www.ic.unicamp.br/~meidanis/courses/mc346/2017s2/prolog/apostila-prolog.pdf)

- Capítulo
    [10](http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-htmlch10)
    do livro
    [Learn Prolog Now](http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-html)
