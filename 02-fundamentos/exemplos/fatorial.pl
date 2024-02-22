% vim: set ft=prolog spell spelllang=pt_br:

:- use_module(library(clpfd)).

%% fat(+N, ?F) is semidet
%
%  Verdeiro se F é o fatorial de N.

:- begin_tests(fatorial).

test(f0) :- fat(0, 1).
test(f1) :- fat(1, 1).
test(f2) :- fat(2, 2).
test(f3) :- fat(3, 6).
test(f4) :- fat(4, 24).
test(f4, fail) :- fat(4, 22).
test(f5, F == 120) :- fat(5, F).

:- end_tests(fatorial).


fat(N, F) :-
    N >= 1,
    N0 is N - 1,
    fat(N0, F0),
    F is N * F0.

fat(0, 1).


% A versão a seguir usa restrições sobre inteiros. Observe que o modo de N
% mudou de + para ?.

%% n_fat(?N, ?F) is nondet
%
%  Verdeiro se F é o fatorial de N.

:- begin_tests(n_fatorial).

test(n_fat0, nondet) :- n_fat(0, 1).
test(n_fat1, nondet) :- n_fat(1, 1).
test(n_fat2, nondet) :- n_fat(2, 2).
test(n_fat3, nondet) :- n_fat(3, 6).
test(n_fat4, nondet) :- n_fat(4, 24).
test(n_fat4, [fail, nondet]) :- n_fat(4, 22).
test(n_fat5, [F == 120, nondet]) :- n_fat(5, F).
test(n_fat5, [N == 5, nondet]) :- n_fat(N, 120).
test(n_fat_all, all([N, F] == [[0, 1], [1, 1], [2, 2], [3, 6], [4, 24]])) :-
    N #=< 4,
    n_fat(N, F).

:- end_tests(n_fatorial).

n_fat(0, 1).

n_fat(N, F) :-
    N #>= 1,
    N0 #= N - 1,
    F #= N * F0,
    n_fat(N0, F0).
