%% super_soma(+XS, ?S) is semidet
%
%  Verdadeiro se S e a soma de todos elementos da lista aninhada XS.

:- begin_tests(super_soma).

test(t0) :- super_soma([[], [], [[], []]], 0).
test(t1) :- super_soma([[1], [2, 3], [4, [5, 6], 7]], 28).
test(t2, S == 36) :- super_soma([[1, 2], 3, [4, [5, 6, [7]], 8]], S).

:- end_tests(super_soma).

super_soma([], 0).

super_soma([X | XS], S) :-
    \+ is_list(X), !,
    super_soma(XS, S1),
    S is X + S1.

super_soma([X | XS], S) :-
    super_soma(X, S1),
    super_soma(XS, S2),
    S is S1 + S2.

% vim: set ft=prolog spell spelllang=pt_br:
