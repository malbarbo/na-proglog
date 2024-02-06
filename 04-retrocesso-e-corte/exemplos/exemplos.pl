:- use_module(library(clpfd)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% selecionado(?X, ?L, ?R) is nondet
%
%  Verdadeiro se R é a lista L sem o elemento X.
%
%  Veja o predicado pré-definido select/3.

:- begin_tests(selecionado).
test(t0, all(r(X, R) == [
             r(4, [2, 6]),
             r(2, [4, 6]),
             r(6, [4, 2])])) :-
    selecionado(X, [4, 2, 6], R).

:- end_tests(selecionado).

selecionado(X, [X|XS], XS).

selecionado(X, [Y|YS], [Y|R]) :-
    selecionado(X, YS, R).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% permutacao(+L, ?P) is nondet
%
%  Verdadeiro se P é uma permutação de L. Se P não estiver instanciado, o
%  predicado gera todas as permutações de L em P.
%
%  Veja o predicado pré-definido permutation/2.

:- begin_tests(permutacao).

test(permutacao, all(P == [[a, b, c], [a, c, b], [b, a, c], [b, c, a], [c, a, b], [c, b, a]])) :-
    permutacao([a, b, c], P).

:- end_tests(permutacao).

permutacao([], []).

permutacao(L, [X|T]) :-
    selecionado(X, L, R),
    permutacao(R, T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% natural(?N) is nondet
%
%  Verdadeiro se N é um número natural.
%
%  Veja o predicado pré-definido between/3.
%
%  Exemplos
%  ?- natural(N).
%  N = 0 ;
%  N = 1 ;
%  N = 2 ;
%  ....

:- begin_tests(natural).

% Pergunta: como testar um gerador infinito?
% Resposta: usando corte com fail e ou ... Tente entender este teste.
test(t0, all(N == [0, 1, 2, 3])) :-
    natural(N),
    (N >= 4, !, fail ; true).

:- end_tests(natural).

natural(0).
natural(N) :-
    N #> 0,
    N #= N0 + 1,
    natural(N0).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% aprovado(?A) is nondet
%
%  Verdadeiro se o aluno A foi aprovado.

:- begin_tests(aprovado).

test(t0, all(A == [jose, andre])) :-
    aluno(A),
    aprovado(A).

:- end_tests(aprovado).

aprovado(A) :-
    faltas(A, F),
    F > 25,
    !,
    fail.

aprovado(A) :-
    media(A, M),
    M >= 6, !.

aprovado(A) :-
    media(A, M),
    exame(A, E),
    (M + E)/2 >= 5.

aluno(jose).
aluno(paulo).
aluno(andre).

faltas(jose, 10).
faltas(paulo, 30).
faltas(andre, 0).

media(jose, 7).
media(paulo, 8).
media(andre, 4).

exame(andre, 6.5).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ordenacao(+L, ?S) is semidet
%
%  Verdadeiro se S é a lista L com os elementos ordenados.

:- begin_tests(ordenacao).

test(ordenacao, S == [2, 3, 4, 7]) :-
    ordenacao([7, 2, 4, 3], S).

test(ordenacao) :-
    ordenacao([8, 1, 4, 3], [1, 3, 4, 8]).

:- end_tests(ordenacao).

ordenacao(L, S) :-
    permutacao(L, S),
    ordenado(S), !.


%% ordenado(+L) is semidet
%
%  Verdadeiro se L é uma lista de números ordenados.

:- begin_tests(ordenado).

test(ordenado0) :- ordenado([]).
test(ordenado1) :- ordenado([_]).
test(ordenadon) :- ordenado([1, 2, 2, 3]).
test(ordenadon, fail) :- ordenado([2, 2, 3, 1]).

:- end_tests(ordenado).

ordenado([]).
ordenado([_]).
ordenado([A, B | R]) :-
    A =< B,
    ordenado([B | R]).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% grafo(+N, -G, -Cs)
%
%  N é o número do grafo G.
grafo(1, grafo([a, b, c, d, e],
               [[a,b],
                [b,a], [b,e], [b,d],
                [c,b],
                [d,c],
                [e,d], [e,c]])).

grafo(2, grafo([a, b, c, d, e, f, g, h, i, j, k, l],
               [[b,a],
                [c,b],
                [d,c],
                [e,d],
                [f,e],
                [g,f],
                [h,g],
                [i,h],
                [j,i],
                [k,j],
                [l,k]])).

:- begin_tests(caminho_hamiltoniano).

test(caminho_hamiltoniano, all(C == [[a, b, e, d, c], [e, d, c, b, a]])) :-
    grafo(1, G),
    caminho_hamiltoniano(G, C).

% Este teste é muito lento!
%test(caminho_hamiltoniano, all(C == [[l, k, j, i, h, g, f, e, d, c, b, a]])) :-
%    grafo(2, G),
%    caminho_hamiltoniano(G, C).

test(caminho_hamiltoniano2, all(C == [[a, b, e, d, c], [e, d, c, b, a]])) :-
    grafo(1, G),
    caminho_hamiltoniano2(G, C).

test(caminho_hamiltoniano2, all(C == [[l, k, j, i, h, g, f, e, d, c, b, a]])) :-
    grafo(2, G),
    caminho_hamiltoniano2(G, C).

:- end_tests(caminho_hamiltoniano).

%% caminho_hamiltoniano(+G, ?C) is nondet
%
%  Verdadeiro se C é um caminho hamiltoniano em G. Se C não for especificado,
%  o predicado encontrada todos os caminhos hamiltonianos.
caminho_hamiltoniano(G, C) :-
    grafo(V, _) = G,
    permutacao(V, C),
    caminho(G, C).

%% caminho_hamiltoniano(+G, ?C) is nondet
%
%  Verdadeiro se C é um caminho hamiltoniano em G. Se C não for especificado,
%  o predicado encontrada todos os caminhos hamiltonianos.
%
%  Versão eficiente do predicado caminho_hamiltoniano/2.
caminho_hamiltoniano2(G, C) :-
    grafo(V, _) = G,
    same_length(V, C),
    caminho_hamiltoniano2(G, C, 1, V).

%% caminho_hamiltoniano(+G, ?C, I, V) is nondet
%
%  Verdadeiro se C é um caminho hamiltoniano em G com todos os vértices em V
%  dispostos a partir do índice I (considerando que o primeiro elemento de C
%  está no índice 1).
caminho_hamiltoniano2(_, _, _, []).

caminho_hamiltoniano2(G, C, I, V) :-
    select(U, V, R),
    nth1(I, C, U),
    subcaminho(C, I, Sub),
    caminho(G, Sub),
    I1 is I + 1,
    caminho_hamiltoniano2(G, C, I1, R).

%% subcaminho(+C, +T, -Sub) is semidet
%
%  Verdadeiro se Sub é o subcaminho no início de C de tamanho T.
subcaminho(C, T, Sub) :-
    length(Sub, T),
    prefix(Sub, C).

%% caminho(+G, C) is semidet
%
%  Verdadeiro se C é um caminho em G.
caminho(G, [U]) :-
    vertice(G, U), !.

caminho(G, [U, V | R]) :-
    aresta(G, U, V), !,
    caminho(G, [V | R]).

%% aresta(+G, ?U, ?W) is nondet
%
%  Verdadeiro se (U, W) é uma aresta de G.
aresta(grafo(_, A), U, W) :-
    member([U, W], A).

%% aresta(+G, ?U) is nondet
%
%  Verdadeiro se U é um vértice de G.
vertice(grafo(V, _), U) :-
    member(U, V).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% primeiro_primo(+N, ?P) is semidet
%
%  Verdadeiro se P é o primeiro primo maior ou igual a N.

:- begin_tests(primeiro_primo).

test(t0, P == 17) :- primeiro_primo(14, P).
test(t0, P == 7) :- primeiro_primo(7, P).

:- end_tests(primeiro_primo).

primeiro_primo(N, P) :-
    P #>= N,
    natural(P), % gerar um candidado
    primo(P),  % testa o candidado
    !.         % interrompe o processo após achar uma solução


%% primo(+X) is semidet
%
%  Verdadeiro se X é um número primo.

primo(X) :-
    menor_divisor(X, 2, Y),
    X =:= Y.

%% menor_divisor(+X, +D, ?Y) is semidet
%
%  Verdadeiro se Y é o menor divisor de X maior ou igual a D.

% X é o menor divisor de X començando com X
menor_divisor(X, X, X) :- !.

% D é o menor divisor de X començando com D se X é divisível por D.
menor_divisor(X, D, D) :-
    divisivel(X, D), !.

% D não é divisor de X
menor_divisor(X, D, Y) :-
    \+ divisivel(X, D),
    D1 is D + 1,
    D1 =< X,
    menor_divisor(X, D1, Y).


%% Divisivel(+X, +Y) is semidet
%
% Verdadeiro se X é divisível por Y.

divisivel(X, Y) :-
    X rem Y =:= 0.
% vim: set ft=prolog spell spelllang=pt_br:
