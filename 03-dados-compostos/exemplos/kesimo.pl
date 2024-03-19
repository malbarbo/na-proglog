%% kesimo(+XS, +K, ?N) is semdet
%
%  Verdadeiro se N é o K-ésimo elemento da lista XS.

:- begin_tests(kesimo).

test(t0) :- kesimo([5, 3, 10], 0, 5).
test(t1) :- kesimo([5, 3, 10], 1, 3).
test(t2, N == 10) :- kesimo([5, 3, 10], 2, N).
test(t4, fail) :- kesimo([5, 3, 10], 4, _).

:- end_tests(kesimo).


kesimo([X | _], 0, X) :- !.

kesimo([_ | XS], K, X) :-
    K > 0,
    K0 is K - 1,
    kesimo(XS, K0, X).

% vim: set ft=prolog spell spelllang=pt_br:

