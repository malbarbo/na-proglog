% Circuito exemplo
%
% A ---|\  X
%      | >o----+
% B -+-|/      |
%    |         +-|\
%    |           | >-- D
%    |         +-|/
%    +-|\ Y    |
%      | )-----+
% C ---|/

%% circuito(A?, B?, C?, D?) is nondet
%
%  Verdadeiro se o circuito exemplo com as entradas A, B e C produz a saída D.

circuito(A, B, C, D) :-
    nand(A, B, X),
    or(B, C, Y),
    and(X, Y, D).

%% and(A?, B?, C?) is nondet
%
%  Verdadeiro se C = A and B.

and(0, 0, 0).
and(0, 1, 0).
and(1, 0, 0).
and(1, 1, 1).

%% or(A?, B?, C?) is nondet
%
%  Verdadeiro se C = A or B.

or(0, 0, 0).
or(0, 1, 1).
or(1, 0, 1).
or(1, 1, 1).

%% not(A?, B?) is nondet
%
%  Verdadeiro se A = not B.

not(0, 1).
not(1, 0).

%% and(A?, B?, C?) is nondet
%
%  Verdadeiro se C = not (A and B).

nand(A, B, C) :-
    and(A, B, N),
    not(N, C).
