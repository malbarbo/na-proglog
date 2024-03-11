:- use_module(library(plunit)).
:- use_module(library(clpfd)).

%% inserido_em(?L, ?X, ?I, ?R) is nondet
%
%  Verdadeiro se R é a lista L com o elemento X inserido da posição I.

:- begin_tests(inserido_em).

test(ex, [nondet, R == [a, b, c, d]]) :-
    inserido_em([a, b, d], c, 2, R).

test(ex, [nondet, N == 1]) :-
    inserido_em([a, b, d], c, N, [a, c, b, d]).

test(ex, [nondet, A == [a, b, d]]) :-
    inserido_em(A, c, _, [a, c, b, d]).

:- end_tests(inserido_em).

inserido_em(L, X, 0, [X | L]).

inserido_em([A | L], X, I, [A | R]) :-
    I #> 0,
    I0 #= I - 1,
    inserido_em(L, X, I0, R).

