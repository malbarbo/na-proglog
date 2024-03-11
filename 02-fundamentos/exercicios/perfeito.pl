:- use_module(library(plunit)).
:- use_module(library(clpfd)).

%% perfeito(+X) is semidet
%
%  Verdadeiro se X é um número perfeito.

:- begin_tests(perfeito).

% FIXME: remover nondet
test(perfeito_6, nondet) :- perfeito(6).
test(perfeito_28, nondet) :- perfeito(28).
test(perfeito_496, nondet) :- perfeito(496).
test(perfeito_5, fail) :- perfeito(5).
test(perfeito_7, fail) :- perfeito(7).
test(perfeito_27, fail) :- perfeito(27).
test(perfeito_29, fail) :- perfeito(29).

:- end_tests(perfeito).

perfeito(X) :-
    X #> 1,
    soma_divisores(X, X).

%% soma_divisores(+X, ?S) is semidet
%
%  Verdadeiro se S é a soma de todos os divisores de X entre 1 e X.
soma_divisores(X, S) :-
    M #= X div 2,
    soma_divisores(X, 1, M, 0, S).

% Exercício: descreva este predicado.
soma_divisores(_, D, F, S, S) :-
    D #> F.

soma_divisores(X, D, F, S0, S) :-
    D #=< F,
    X mod D #= 0,
    S1 #= S0 + D,
    D1 #= D + 1,
    soma_divisores(X, D1, F, S1, S).

soma_divisores(X, D, F, S0, S) :-
    D #=< F,
    X mod D #\= 0,
    D1 #= D + 1,
    soma_divisores(X, D1, F, S0, S).

% vim: set ft=prolog spell spelllang=pt_br:
