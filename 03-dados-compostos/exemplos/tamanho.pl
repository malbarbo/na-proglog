:- use_module(library(clpfd)).

% Versão inicial com XS instanciado

%% tamanho(+XS, ?T) is nondet
%
%  Verdadeiro se a quantidade de elementos na lista XS é T.

:- begin_tests(tamanho).

test(t0) :- tamanho([], 0).
test(t1) :- tamanho([1], 1).
test(t1, fail) :- tamanho([1], 2).
test(t2) :- tamanho([7, 2], 2).
test(t2, T == 3) :- tamanho([7, 2, 3], T).

:- end_tests(tamanho).


tamanho([_ | XS], T) :-
    tamanho(XS, T0),
    T is T0 + 1.

tamanho([], 0).


% Versão usando restrição sobre inteiros

%% tamanho(?XS, ?T) is nondet
%
%  Verdadeiro se a quantidade de elementos na lista XS é T.

:- begin_tests(tamanho_r).

test(t0) :- tamanho_r([], 0).
test(t1) :- tamanho_r([1], 1).
test(t1, fail) :- tamanho_r([1], 2).
test(t2) :- tamanho_r([7, 2], 2).
test(t2, T == 3) :- tamanho_r([7, 2, 3], T).
% nondet para evitar o warning.
% Note que idealmente o predicado deveria funcionar
% como length(A, 2), sem deixar escolha.
test(lista, A = [_, _], nondet) :- tamanho_r(A, 2).
test(geral, all((L, T) = [([], 0), ([_], 1), ([_, _], 2)])) :- T #=< 2, tamanho_r(L, T).

:- end_tests(tamanho_r).


tamanho_r([], 0).
tamanho_r([_ | XS], T) :-
    T #> 0,
    T #= T0 + 1,
    tamanho_r(XS, T0).



% Versão usando acumulador

%% tamanho_acc(+XS, ?T) is semidet
%
%  Verdadeiro se a quantidade de elementos de XS é T.

:- begin_tests(tamanho_acc).

test(tamanho_acc2, T == 3) :-
    tamanho([4, 5, 2], T).

test(tamanho_acc3, T == 11) :-
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

% vim: set ft=prolog spell spelllang=pt_br:

