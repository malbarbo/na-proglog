% vim: set ft=prolog spell spelllang=pt_br:

:- use_module(library(clpfd)).

%% quadrado(+X, ?Y) is semidet
%
%  Verdadeiro se Y é o quadrado de X.

:- begin_tests(quadrado).

test(quadrado4) :- quadrado(4, 16).
test(quadrado4, fail) :- quadrado(4, 19).
test(quadrado3, Q == 9) :- quadrado(3, Q).

:- end_tests(quadrado).

quadrado(X, Y) :-
    Y is X * X.


% A versão a seguir usa restrições sobre inteiros. Observe que o modo de X
% mudou de + para ?.

%% n_quadrado(?X, ?Y) is nondet
%
%  Verdadeiro se Y é o quadrado de X.

:- begin_tests(n_quadrado).

test(n_quadrado4) :- n_quadrado(4, 16).
test(n_quadrado4, fail) :- n_quadrado(4, 19).
test(n_quadrado3, Y == 9) :- n_quadrado(3, Y).
test(n_quadrado3, all(X == [-4, 4])) :- n_quadrado(X, 16).
test(n_quadrado_all, all([X, Y] == [[-2, 4], [-1, 1], [0, 0], [1, 1], [2, 4]])) :-
    Y #=< 4,
    n_quadrado(X, Y).

:- end_tests(n_quadrado).

n_quadrado(X, Y) :-
    Y #= X * X,
    label([X, Y]).
