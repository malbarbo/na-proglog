%% comprimida(+XS, ?YS) is nondet
%
%  Verdadeiro se XS comprimida é YS, isto é, sem elementos repetidos
%  consecutivos.

:- begin_tests(comprimida).

test(t0) :- comprimida([], []).
test(t1) :- comprimida([x], [x]).
test(t2) :- comprimida([3, 3, 4, 4, 4, 3, 5, 5, 5], [3, 4, 3, 5]).

:- end_tests(comprimida).

comprimida([], []).

comprimida([X], [X]) :- !.

comprimida([X, X | XS], YS) :-
    comprimida([X | XS], YS), !.

comprimida([X, Y | XS], [X | YS]) :-
    dif(X, Y),
    comprimida([Y | XS], YS).

% vim: set ft=prolog spell spelllang=pt_br:
