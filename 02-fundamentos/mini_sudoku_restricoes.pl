:- use_module(library(clpfd)).

%% mini_sudoku(?A, ?B, ?C, ?D,
%              ?E, ?F, ?G, ?H,
%              ?I, ?J, ?K, ?L,
%              ?M, ?N, ?O, ?P) is nondet
%
% Verdadeiro se A, B, ..., P formam a solução de um
% mini sudoku conforme o esquema abaixo
%
% A  B | C  D
% E  F | G  H
%------+-----
% I  J | K  L
% M  N | O  P
%
% Exemplo de um mini sudoku resolvido
% 4  2 | 1  3
% 3  1 | 4  2
%------+-----
% 2  4 | 3  1
% 1  3 | 2  4
%
:- begin_tests(mini_sudoku).

test(mini_sudoku_1, [[A, O] == [4, 2], nondet]) :-
    mini_sudoku(A, 2, 1, 3, 3, 1, 4, 2, 2, 4, 3, 1, 1, 3, O, 4).

:- end_tests(mini_sudoku).

mini_sudoku(A, B, C, D,
            E, F, G, H,
            I, J, K, L,
            M, N, O, P) :-
    A in 1..4,
    B in 1..4,
    C in 1..4,
    D in 1..4,
    E in 1..4,
    F in 1..4,
    G in 1..4,
    H in 1..4,
    I in 1..4,
    J in 1..4,
    K in 1..4,
    L in 1..4,
    M in 1..4,
    N in 1..4,
    O in 1..4,
    P in 1..4,
    diferentes(A, B, C, D), % linhas
    diferentes(E, F, G, H),
    diferentes(I, J, K, L),
    diferentes(M, N, O, P),
    diferentes(A, E, I, M), % colunas
    diferentes(B, F, J, N),
    diferentes(C, G, K, O),
    diferentes(D, H, L, P),
    diferentes(A, B, E, F), % blocos
    diferentes(C, D, G, H),
    diferentes(I, J, M, N),
    diferentes(K, L, O, P).


%% diferentes(?A, ?B, ?C, ?D) is semidet
%
%  Verdadeiro se A, B, C e D são diferentes par a par.
diferentes(A, B, C, D) :- all_distinct([A, B, C, D]).

% vim: set ft=prolog spell spelllang=pt_br:
