:- use_module(library(plunit)).
:- use_module(library(clpfd)).

%% soma_zero(?L, ?A, ?B) is nondet
%
%  Verdadeiro se A e B são elementos distintos da lista L e a soma de A e B é 0.

:- begin_tests(soma_zero).

test(soma_zero_ok, [nondet, (A, B) = (3, -3)]) :-
    soma_zero([1, 3, 4, -3, 2], A, B).

:- end_tests(soma_zero).

soma_zero(L, A, B) :-
    dif(A, B),
    member(A, L),
    member(B, L),
    A + B #= 0.


% vim: set ft=prolog spell spelllang=pt_br:
