% Exercício 2.7

%% triangulo(+A, +B, +C, ?T) is nondet
%
%  Verdadeiro se A, B e C formam um triângulo do tipo T.

:- begin_tests(triangulo).

test(triangulo_equilatero, set(T == [equilatero, isosceles])) :-
    triangulo(3, 3, 3, T).

test(triangulo_isosceles, [nondet, T == isosceles]) :-
    triangulo(2, 3, 3, T).

test(triangulo_escaleno, [nondet, T == escaleno]) :-
    triangulo(3, 4, 5, T).

:- end_tests(triangulo).


triangulo(A, B, C, equilatero) :-
    triangulo(A, B, C),
    A =:= B,
    B =:= C.

triangulo(A, B, C, isosceles) :-
    triangulo(A, B, C),
    A =:= B.

triangulo(A, B, C, isosceles) :-
    triangulo(A, B, C),
    A =:= C.

triangulo(A, B, C, isosceles) :-
    triangulo(A, B, C),
    B =:= C.

triangulo(A, B, C, escaleno) :-
    triangulo(A, B, C),
    A =\= B,
    A =\= C,
    B =\= C.

%% triangulo(+A, +B, +C) is semidet
%  
%  Verdadeiro se se A, B e C formam um triângulo.

triangulo(A, B, C) :-
    A > 0,
    B > 0,
    C > 0,
    A + B > C,
    A + C > B,
    B + C > A.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercício 2.8

%% area(+F, ?A) is semidet
%
%  Verdadeiro se A é a área figura F.

:- begin_tests(area).

test(area_circulo, A =:= 12.566370614359172) :-
    area(circulo(2), A).

test(area_quadrado, A =:= 16) :-
    area(quadrado(4), A).

test(area_retangulo, A =:= 12) :-
    area(retangulo(3, 4), A).

:- end_tests(area).


area(circulo(R), A) :-
    A is pi * R * R.

area(quadrado(L), A) :-
    A is L * L.

area(retangulo(H, L), A) :-
    A is H * L.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercício 2.9

%% soma_quadrado_maiores(+A, +B, +C, ?S)
%  
%  Verdadeiro se S é a soma dos quadrados dos dois maiores números entre
%  A, B e C.

:- begin_tests(soma_quadrado_maiores).

test(soma_quadrado, S =:= 41) :-
    soma_quadrado_maiores(3, 4, 5, S).

test(soma_quadrado, S =:= 41) :-
    soma_quadrado_maiores(4, 3, 5, S).

:- end_tests(soma_quadrado_maiores).


soma_quadrado_maiores(A, B, C, S) :-
    A >= B, !,
    maximo(B, C, X),
    soma_quadrado(A, X, S).

soma_quadrado_maiores(A, B, C, S) :-
    B > A,
    maximo(A, C, X),
    soma_quadrado(B, X, S).

soma_quadrado(A, B, S) :-
    S is A^2 + B^2.


%% maximo(+A, +B, ?C) is semidet
%  
%  Verdadeiro se C é o valor máximo entre A e B.

maximo(A, B, A) :-
    A >= B, !.

maximo(A, B, B) :-
    B > A.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercício 2.10

%% primo(+X)
%  
%  Verdadeiro se X é um número primo.

:- begin_tests(primo).

test(primo_1, fail) :- primo(1).
test(primo_2) :- primo(2).
test(primo_3) :- primo(3).
test(primo_5) :- primo(5).
test(primo_7) :- primo(7).
test(primo_19) :- primo(19).
test(primo_4, fail) :- primo(4).
test(primo_6, fail) :- primo(6).
test(primo_8, fail) :- primo(8).
test(primo_9, fail) :- primo(9).

:- end_tests(primo).


primo(X) :-
    menor_divisor(X, 2, Y),
    X =:= Y.


%% menor_divisor(+X, +D, ?Y) is semidet
%
%  Verdadeiro se Y é o menor divisor de X maior ou igual a D.

% X é o menor divisor de X començando com X
menor_divisor(X, X, X) :- !.

% D é o menor divisor de X començando com D se X é divisível por D.
menor_divisor(X, D, D) :-
    divisivel(X, D), !.

% D não é divisor de X
menor_divisor(X, D, Y) :-
    \+ divisivel(X, D),
    D1 is D + 1,
    D1 =< X,
    menor_divisor(X, D1, Y).


%% Divisivel(+X, +Y) is semidet
%
% Verdadeiro se X é divisível por Y.

divisivel(X, Y) :-
    X rem Y =:= 0.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercício 2.12

%% perfeito(+X) is semidet
%
%  Verdadeiro se X é um número perfeito.

:- begin_tests(perfeito).

test(perfeito_6) :- perfeito(6).
test(perfeito_28) :- perfeito(28).
test(perfeito_496) :- perfeito(496).
test(perfeito_5, fail) :- perfeito(5).
test(perfeito_7, fail) :- perfeito(7).
test(perfeito_27, fail) :- perfeito(27).
test(perfeito_29, fail) :- perfeito(29).

:- end_tests(perfeito).

perfeito(X) :-
    soma_divisores(X, S),
    X =:= S.

%% soma_divisores(+X, ?S) is semidet
%
%  Verdadeiro se S é a soma de todos os divisores de X entre 1 e X.
soma_divisores(X, S) :-
    soma_divisores(X, 1, 0, S).

% Exercício: descreva este predicado.
soma_divisores(X, D, S, S) :-
    D >= X, !.

soma_divisores(X, D, S0, S) :-
    divisivel(X, D), !,
    S1 is S0 + D,
    D1 is D + 1,
    soma_divisores(X, D1, S1, S).

soma_divisores(X, D, S0, S) :-
    \+ divisivel(X, D),
    D1 is D + 1,
    soma_divisores(X, D1, S0, S).

% vim: set ft=prolog spell spelllang=pt_br:
