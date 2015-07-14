% Exemplo 3.1

%% tamanho(+XS, ?T) is nondet
%
%  Verdadeiro se a quantidade de elementos na lista XS é T.
%
%  Veja o predicado pré-definido length/2.

:- begin_tests(tamanho).

test(t0) :- tamanho([], 0).
test(t1) :- tamanho([1], 1).
test(t2) :- tamanho([7, 2], 2).

:- end_tests(tamanho).


tamanho([_ | XS], T) :-
	tamanho(XS, T0),
	T is T0 + 1.

tamanho([], 0).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exemplo 3.2

%% kesimo(+XS, +K, ?N) is semdet
%
%  Verdadeiro se N é o K-ésimo elemento da lista XS.
%
%  Veja o predicado pré-definido nth0/3.

:- begin_tests(kesimo).

test(t0) :- kesimo([5, 3, 10], 0, 5).
test(t1) :- kesimo([5, 3, 10], 1, 3).
test(t2) :- kesimo([5, 3, 10], 2, 10).
test(t4, fail) :- kesimo([5, 3, 10], 4, _).

:- end_tests(kesimo).


kesimo([X | _], 0, X) :- !.

kesimo([_ | XS], K, X) :-
    K > 0,
    K0 is K - 1,
    kesimo(XS, K0, X).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exemplo 3.3

%% comprimida(+XS, ?YS) is nondet
%
%  Verdadeiro se XS comprimida é YS, isto é, sem elementos repetidos
%  consecutivos.

:- begin_tests(comprimida).

test(t0) :- comprimida([], []).
test(t1) :- comprimida([x], [x]).
test(t2) :- comprimida([3, 3, 4, 4, 4, 3, 5, 5, 5], [3, 4, 3, 5]).

:- end_tests(comprimida).

comprimida([], []).

comprimida([X | XS], YS) :-
	comprimida(XS, YS),
	[X | _] = YS, !.

comprimida([X | XS], [X | YS]) :-
	comprimida(XS, YS),
	[X | _] \= YS.


%% comprimida2(+XS, ?YS) is nondet
%
%  Verdadeiro se XS comprimida é YS, isto é, sem elementos repetidos
%  consecutivos.

:- begin_tests(comprimida2).

test(t0) :- comprimida2([], []).
test(t1) :- comprimida2([x], [x]).
test(t2) :- comprimida2([3, 3, 4, 4, 4, 3, 5, 5, 5], [3, 4, 3, 5]).

:- end_tests(comprimida2).

comprimida2([], []).

comprimida2([X], [X]) :- !.

comprimida2([X, X | XS], YS) :-
	comprimida2([X | XS], YS), !.

comprimida2([X, Y | XS], [X | YS]) :-
	X \== Y,
	comprimida2([Y | XS], YS).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exemplo 3.4

%% membro(?X, ?XS) is nondet
%
%  Verdadeiro se X é um elemento de XS.
%
%  Veja o predicado pré-definido member/2.

:- begin_tests(membro).

test(t0, [nondet]) :- membro(1, [1, 3, 7]).
test(t1, [nondet]) :- membro(3, [1, 3, 7]).
test(t2, [nondet]) :- membro(7, [1, 3, 7]).
test(t3, all(X == [1, 3, 7, -2])) :- membro(X, [1, 3, 7, -2]).

:- end_tests(membro).

membro(X, [X | _]).
membro(X, [_ | XS]) :-
    membro(X, XS).


%% membrochk(+X, ?XS) is semidet
%
%  Verdadeiro se X é um elemento de XS.
%
%  Veja o predicado pré-definido memberchk/2.

:- begin_tests(membrochk).

test(t0) :- membrochk(1, [1, 3, 7]).
test(t1) :- membrochk(7, [1, 3, 7]).
test(t2, X == 1) :- membrochk(X, [1, 3, 7]).
test(t3, [fail]) :- membrochk(5, [1, 3, 7]).

:- end_tests(membrochk).

membrochk(X, [X | _]) :- !.
membrochk(X, [_ | XS]) :-
    membrochk(X, XS).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exemplo 3.5

%% concatenacao(?X, ?Y, ?Z) is nondet
%
%  Verdadeiro se Z é a concatenação de X com Y.
%
%  Veja o predicado pré-definido append/3.

:- begin_tests(concatenacao).

test(t0) :- concatenacao([1, 2], [3, 4, 5], [1, 2, 3, 4, 5]).
test(t1, [nondet, XS == [1, 2, 4]]) :- concatenacao(XS, [3], [1, 2, 4, 3]).
test(t2, YS == [4, 3]) :- concatenacao([1, 2], YS, [1, 2, 4, 3]).
test(t3, all(p(XS, YS) == [
         p([], [1, 2, 3]),
         p([1], [2, 3]),
         p([1, 2], [3]),
         p([1, 2, 3], [])])) :-
    concatenacao(XS, YS, [1, 2, 3]).


:- end_tests(concatenacao).

concatenacao([], YS, YS).

concatenacao([X | XS], YS, [X | XSYS]) :-
    concatenacao(XS, YS, XSYS).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exemplo 3.6

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exemplo 3.8

%% tamanho_acc(+XS, ?T) is semidet
%
%  Verdadeiro se a quantidade de elementos de XS é T.

:- begin_tests(tamanho_acc).

test(tamanho_acc2, T =:= 3) :-
    tamanho([4, 5, 2], T).

test(tamanho_acc3, T =:= 11) :-
    tamanho_acc([4, 5, 2], 8, T).

:- end_tests(tamanho_acc).

tamanho_acc(L, T) :-
    tamanho_acc(L, 0, T).

%% tamanho(+XS, +Acc, ?T) is semidet
%
%  Verdadeiro se a quantidade de elementos de XS + Acc é T.

tamanho_acc([], Acc, Acc).

tamanho_acc([_|R], Acc, T) :-
    Acc1 is Acc + 1,
    tamanho_acc(R, Acc1, T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exemplo 3.9

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exemplo 3.10

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
