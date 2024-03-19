%% permutacao(+L, ?P) is nondet
%
%  Verdadeiro se P é uma permutação de L.

:- begin_tests(permutacao).

test(permutacao, all(P == [[a, b, c], [a, c, b], [b, a, c], [b, c, a], [c, a, b], [c, b, a]])) :-
    permutacao([a, b, c], P).

:- end_tests(permutacao).

permutacao([], []).

permutacao(L, [X|T]) :-
    select(X, L, R),
    permutacao(R, T).
