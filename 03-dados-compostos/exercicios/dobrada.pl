:- use_module(library(plunit)).

%% dobrada(?L) is nondet
%
%  Verdadeiro se L é uma lista com dois blocos consecutivos de elementos
%  iguais.

:- begin_tests(dobrada).

% FIXME: remover nondet
test(dobrada, nondet) :- dobrada([a, b, c, a, b, c]).
test(dobrada_fail, fail) :- dobrada([a, b, a]).

test(dobrada2) :- dobrada2([a, b, c, a, b, c]).
test(dobrada2_fail, fail) :- dobrada2([a, b, a]).

:- end_tests(dobrada).

% versão simples
dobrada(L) :-
    append(A, A, L).

% versão eficiente
dobrada2(L) :-
    length(L, T),
    T rem 2 =:= 0,
    N is T div 2,
    divisao_em(N, L, A, A).


%% divisao_em(+N, ?A, ?B, ?C) is nondet
%
%  Verdadeiro se A = [A_0, A_1, ..., A_N, A_(N+1), ..., A_K] e
%  B = [A_0, ..., A_N] e C = [A_(N+1), ..., A_K].

divisao_em(N, [A|As], [A|Bs], Cs) :-
    N > 0,
    N0 is N - 1,
    divisao_em(N0, As, Bs, Cs).

divisao_em(0, A, [], A).

% vim: set ft=prolog spell spelllang=pt_br:
