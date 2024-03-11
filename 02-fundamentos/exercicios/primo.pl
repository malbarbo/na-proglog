:- use_module(library(plunit)).
:- use_module(library(clpfd)).

%% primo(?X) is nondet
%
%  Verdadeiro se X é um número primo.

:- begin_tests(primo).

% FIXME: remover nondet
test(primo_1, [nondet, fail]) :- primo(1).
test(primo_2, nondet) :- primo(2).
test(primo_3, nondet) :- primo(3).
test(primo_5, nondet) :- primo(5).
test(primo_7, nondet) :- primo(7).
test(primo_19, nondet) :- primo(19).
test(primo_4, [nondet, fail]) :- primo(4).
test(primo_6, [nondet, fail]) :- primo(6).
test(primo_8, [nondet, fail]) :- primo(8).
test(primo_9, [nondet, fail]) :- primo(9).

:- end_tests(primo).

primo(X) :-
    X #> 1,
    M #= X div 2,
    tem_divisores(X, 2, M, nao),
    label([X]).

%% tem_divisores(?X, +S, +F, ?R) is nondet
%
%  Verdadeiro se R=nao e X não tem nenhum divisor entre S e F ou
%  R=sim e X tem algum divisor entre S e F.

tem_divisores(_, S, F, nao) :-
    S #> F.

tem_divisores(X, S, F, sim) :-
    S #=< F,
    X mod S #= 0.

tem_divisores(X, S, F, R) :-
    S #=< F,
    X mod S #\= 0,
    S1 #= S + 1,
    tem_divisores(X, S1, F, R).

% vim: set ft=prolog spell spelllang=pt_br:
