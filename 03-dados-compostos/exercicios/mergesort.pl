:- use_module(library(plunit)).

%% mergesort(+A, -S) is semidet
%
%  Verdadeiro se S é uma permutação de A ordenada. Ou seja, S é A ordenada.

:- begin_tests(mergesort).

test(mergesort, S == [3, 4, 8, 12, 17]) :-
    mergesort([12, 4, 8, 3, 17], S).

:- end_tests(mergesort).

mergesort([], []).
mergesort([A], [A]).
mergesort([A0,A1|T], S) :-
    divisao([A0,A1|T], L1, L2),
    mergesort(L1, S1),
    mergesort(L2, S2),
    merge(S1, S2, S), !.

%% divisao(+A, ?B, ?C) is semidet
%
%  Verdadeiro se B concatenado com C é A. Os tamanhos de B e C pode ser
%  diferentes no máximo em 1.

divisao(A, B, C) :-
    length(A, T),
    N is T div 2,
    divisao_em(N, A, B, C).


%% divisao_em(+N, ?A, ?B, ?C) is nondet
%
%  Verdadeiro se A = [A_0, A_1, ..., A_N, A_(N+1), ..., A_K] e
%  B = [A_0, ..., A_N] e C = [A_(N+1), ..., A_K].

divisao_em(N, [A|As], [A|Bs], Cs) :-
    N > 0,
    N0 is N - 1,
    divisao_em(N0, As, Bs, Cs).

divisao_em(0, A, [], A).


%% merge(+A, +B, ?C) is semidet
%
%  Verdadeiro se C é a intercalação das listas A e B.

merge(A, [], A).
merge([], B, B).
merge([A|As], [B|Bs], [A|Cs]) :-
    A =< B,
    merge(As, [B|Bs], Cs).

merge([A|As], [B|Bs], [B|Cs]) :-
    A > B,
    merge([A|As], Bs, Cs).

% vim: set ft=prolog spell spelllang=pt_br:
