% vim: set ft=prolog spell spelllang=pt_br:

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

:- begin_tests(mini_sudoku).

test(mini_sudoku_1, [[A, O] == [4, 2], nondet]) :-
    mini_sudoku(A, 2, 1, 3, 3, 1, 4, 2, 2, 4, 3, 1, 1, 3, O, 4).

:- end_tests(mini_sudoku).

mini_sudoku(A, B, C, D,
            E, F, G, H,
            I, J, K, L,
            M, N, O, P) :-
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
    diferentes(K, L, O, P),
    valor1a4(A),
    valor1a4(B),
    valor1a4(C),
    valor1a4(D),
    valor1a4(E),
    valor1a4(F),
    valor1a4(G),
    valor1a4(H),
    valor1a4(I),
    valor1a4(J),
    valor1a4(K),
    valor1a4(L),
    valor1a4(M),
    valor1a4(N),
    valor1a4(O),
    valor1a4(P).


%% valor1a4(?A) is nondet
%
%  Verdadeiro se A é um dos valores 1, 2, 3 ou 4.
valor1a4(1).
valor1a4(2).
valor1a4(3).
valor1a4(4).


%% diferentes(?A, ?B, ?C, ?D) is semidet
%
%  Verdadeiro se A, B, C e D são diferentes par a par.
diferentes(A, B, C, D) :-
    dif(A, B),
    dif(A, C),
    dif(A, D),
    dif(B, C),
    dif(B, D),
    dif(C, D).
