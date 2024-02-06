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
    dif(A, B).

%% cor(A?) is nondet
%
%  Verdadeiro se A é uma cor.

cor(verde).
cor(azul).
cor(amarelo).
