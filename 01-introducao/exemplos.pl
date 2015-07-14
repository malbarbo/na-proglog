%% Exemplo 1.1

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
    and(A, B, NOTC),
    not(NOTC, C).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Exemplo 1.2

%  Mapa exemplo
%
%  +-------+-------+
%  |   A   |   C   |
%  |       +-------+
%  +-------|   D   |
%  |   B   +-------+
%  |       |   E   |
%  +-------+-------+

%% colocarao(A?, B?, C?, D?, E?) is nondet
%
%  Verdadeiro se A, B, C, D, E são cores que podem colorir as respectivas
%  regiões do mapa exemplo de maneira que duas regiões adjacentes não tenham a
%  mesma cor.

coloracao(A, B, C, D, E) :-
	cor_dif(A, C),
	cor_dif(A, D),
	cor_dif(A, B),
	cor_dif(B, D),
	cor_dif(B, E),
	cor_dif(C, D),
	cor_dif(D, E).

%% cor_dif(A?, B?) is nondet
%
%  Verdeiro se A é uma cor diferente da cor B.

cor_dif(A, B) :-
	cor(A),
	cor(B),
	A \== B.

%% cor(A?) is nondet
%
%  Verdadeiro se A é uma cor.

cor(verde).
cor(azul).
cor(amarelo).

% vim: set ft=prolog spell spelllang=pt_br:
