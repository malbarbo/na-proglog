%% ordenacao(+L, ?S) is semidet
%
%  Verdadeiro se S é a lista L com os elementos em ordem não decrescente.

:- begin_tests(ordenado).

test(ordenado, S == [2, 3, 4, 7]) :-
    ordenado([7, 2, 4, 3], S).

test(ordenado) :-
    ordenado([8, 1, 4, 3], [1, 3, 4, 8]).

:- end_tests(ordenado).

ordenado(L, S) :-
    permutation(L, S),
    em_ordem(S), !.


%% em_ordem(+L) is semidet
%
%  Verdadeiro se L é uma lista de número em ordem não descrescente.

:- begin_tests(em_ordem).

test(em_ordem0) :- em_ordem([]).
test(em_ordem1) :- em_ordem([_]).
test(em_ordemn) :- em_ordem([1, 2, 2, 3]).
test(em_ordemn, fail) :- em_ordem([2, 2, 3, 1]).

:- end_tests(em_ordem).

em_ordem([]).
em_ordem([_]).
em_ordem([A, B | R]) :-
    A =< B,
    em_ordem([B | R]).
