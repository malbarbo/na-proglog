%% reverso(+A, ?R) is nondet
%
%  Verdadeiro se o reverso da lista A é R.
%
%  Veja o predicado pré-definido reverse/2.

:- begin_tests(reverso).

test(reverso) :-
    reverso([1, 2, 3], [3, 2, 1]).

test(reverso, R == [8, 3, 4]) :-
    reverso([4, 3, 8], R).

:- end_tests(reverso).

reverso([], []).

reverso([A|As], R) :-
    reverso(As, Rs),
    append(Rs, [A], R).


%% reverso_acc(+A, ?R) is nondet
%
%  Verdadeiro se o reverso da lista A é R.

:- begin_tests(reverso_acc).

test(reverso_acc, R == [8, 3, 4]) :-
    reverso_acc([4, 3, 8], R).

test(reverso_acc, [nondet]) :-
    reverso_acc([1, 2, 9, 6], [6, 9, 2, 1]).

test(reverso_acc3, [nondet]) :-
    reverso_acc([9, 6], [1, 2], [6, 9, 1, 2]).

:- end_tests(reverso_acc).

reverso_acc(A, R) :-
    reverso_acc(A, [], R).


%% reverso_acc(+A, +Acc, ?R) is nondet
%
%  Verdadeiro se o reverso da lista A concatenado com Acc é R.

reverso_acc([], Acc, Acc).

reverso_acc([A|As], Acc, R) :-
    reverso_acc(As, [A|Acc], R).

% vim: set ft=prolog spell spelllang=pt_br:
