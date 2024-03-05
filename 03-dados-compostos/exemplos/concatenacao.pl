%% concatenacao(?X, ?Y, ?Z) is nondet
%
%  Verdadeiro se Z é a concatenação de X com Y.

:- begin_tests(concatenacao).

test(t0) :- concatenacao([1, 2], [3, 4, 5], [1, 2, 3, 4, 5]).
test(t1, [nondet, XS == [1, 2, 4]]) :- concatenacao(XS, [3], [1, 2, 4, 3]).
test(t2, YS == [4, 3]) :- concatenacao([1, 2], YS, [1, 2, 4, 3]).
test(t3, all((XS, YS) == [
         ([], [1, 2, 3]),
         ([1], [2, 3]),
         ([1, 2], [3]),
         ([1, 2, 3], [])])) :-
    concatenacao(XS, YS, [1, 2, 3]).


:- end_tests(concatenacao).

concatenacao([], YS, YS).

concatenacao([X | XS], YS, [X | XSYS]) :-
    concatenacao(XS, YS, XSYS).


%% concatenacao_dif(?X, ?Y, ?Z) is nondet
%
%  Verdadeiro se Z é a concatenação de X com Y. Este predicado é diferente de
%  concatenacao/3 porque os argumentos devem ser diferença de lista.

:- begin_tests(concatenacao_dif).

test(t0, r(X, Z) = r([4, 5 | Y], [1, 2, 3, 4, 5 | D])) :-
    concatenacao_dif([1, 2, 3 | X]-X, [4, 5 | Y]-Y, Z-D).

test(t0, r(A, B) = r([1, 2, 3 | B], [4, 5 | Y])) :-
    concatenacao_dif(A-B, [4, 5 | Y]-Y, [1, 2, 3, 4, 5 | D]-D).

:- end_tests(concatenacao_dif).

concatenacao_dif(A-B, B-C, A-C).

% vim: set ft=prolog spell spelllang=pt_br:
