:- use_module(library(plunit)).
:- use_module(library(clpfd)).

%% sequencia(?L, ?N) is nondet
%
%  Verdadeira se L é uma lista com os primeiros N números naturais em ordem.

:- begin_tests(sequencia).

% FIXME: nondet não deveria ser necessário
test(seq0, nondet) :- sequencia([], 0).
test(seq1) :- sequencia([0], 1).
test(seq2) :- sequencia([0, 1], 2).
test(seq3, [nondet, L == [0, 1, 2]]) :- sequencia(L, 3).
test(seq4, N == 4) :- sequencia([0, 1, 2, 3], N).

:- end_tests(sequencia).

sequencia([], 0).
sequencia(L, N) :-
    N #> 0,
    sequencia_comeca(L, 0, N).

sequencia_comeca([], N, N).
sequencia_comeca([X | XS], X, N) :-
    X #< N,
    X1 #= X + 1,
    sequencia_comeca(XS, X1, N).


% vim: set ft=prolog spell spelllang=pt_br:
