:- use_module(library(plunit)).

% Exemplo 2.1

%% quadrado(+X, ?Y) is semidet
%
%  Verdadeiro se Y é o quadrado de X.

:- begin_tests(quadrado).

test(quadrado4) :- quadrado(4, 16).
test(quadrado3, Q == 9) :- quadrado(3, Q).

:- end_tests(quadrado).

quadrado(X, Y) :-
    Y is X * X.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exemplo 2.2

%% fat(+N, ?F) is semidet
%
%  Verdeiro se F é o fatorial de N.

:- begin_tests(fatorial).

test(f0) :- fat(0, 1).
test(f1) :- fat(1, 1).
test(f2) :- fat(2, 2).
test(f3) :- fat(3, 6).
test(f4) :- fat(4, 24).
test(f4, [fail]) :- fat(4, 22).
test(f5, F == 120) :- fat(5, F).

:- end_tests(fatorial).


fat(N, F) :-
    N >= 1,
    N0 is N - 1,
    fat(N0, F0),
    F is N * F0.

fat(0, 1).

% vim: set ft=prolog spell spelllang=pt_br:
