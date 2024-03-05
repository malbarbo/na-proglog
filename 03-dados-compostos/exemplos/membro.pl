%% membro(?X, ?XS) is nondet
%
%  Verdadeiro se X é um elemento de XS.

:- begin_tests(membro).

test(t0, nondet) :- membro(1, [1, 3, 7]).
test(t1, nondet) :- membro(3, [1, 3, 7]).
test(t2, nondet) :- membro(7, [1, 3, 7]).
test(t3, all(X == [1, 3, 7, -2])) :- membro(X, [1, 3, 7, -2]).

:- end_tests(membro).

membro(X, [X | _]).
membro(X, [_ | XS]) :-
    membro(X, XS).


%% membrochk(+X, ?XS) is semidet
%
%  Verdadeiro se X é um elemento de XS.

:- begin_tests(membrochk).

test(t0) :- membrochk(1, [1, 3, 7]).
test(t1) :- membrochk(7, [1, 3, 7]).
test(t2, X == 1) :- membrochk(X, [1, 3, 7]).
test(t3, [fail]) :- membrochk(5, [1, 3, 7]).

:- end_tests(membrochk).

membrochk(X, [X | _]) :- !.
membrochk(X, [_ | XS]) :-
    membrochk(X, XS).

% vim: set ft=prolog spell spelllang=pt_br:
