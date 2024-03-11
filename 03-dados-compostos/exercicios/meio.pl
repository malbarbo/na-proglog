:- use_module(library(plunit)).

%% meio(?L, ?X) is nondet
%
%  Verdadeira se X é o elemento do meio da lista L.

:- begin_tests(meio).

test(meio1, X == 10) :- meio([10], X).
test(meio3, X == 1) :- meio([2, 1, 4], X).
test(meio4, fail) :- meio([_, _, _, _], _).
test(meio_impar, nondet, R = [[12], [_, 12, _], [_, _, 12, _, _]]) :-
    findnsols(3, L, meio(L, 12), R).

:- end_tests(meio).

meio(L, X) :-
    length(L, T),
    T rem 2 =:= 1,
    N is T div 2,
    nth0(N, L, X).

% vim: set ft=prolog spell spelllang=pt_br:
