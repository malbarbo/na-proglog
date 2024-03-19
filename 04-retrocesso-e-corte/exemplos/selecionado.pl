%% selecionado(?X, ?L, ?R) is nondet
%
%  Verdadeiro se R é a lista L sem o elemento X.

:- begin_tests(selecionado).
test(t0, all((X, R) == [
             (4, [2, 6]),
             (2, [4, 6]),
             (6, [4, 2])])) :-
    selecionado(X, [4, 2, 6], R).

:- end_tests(selecionado).

selecionado(X, [X|XS], XS).

selecionado(X, [Y|YS], [Y|R]) :-
    selecionado(X, YS, R).
