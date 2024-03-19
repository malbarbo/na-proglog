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
%  Verdadeiro se C é um caminho hamiltoniano em G.
caminho_hamiltoniano(G, C) :-
    grafo(V, _) = G,
    permutation(V, C),
    caminho(G, C).

%% caminho_hamiltoniano(+G, ?C) is nondet
%
%  Verdadeiro se C é um caminho hamiltoniano em G.
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
