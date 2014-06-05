% Os predicados deste arquivo não foram escritos para serem eficientes, mas
% para serem claros e exemplificar o conteúdo estudado.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercício 4.5

%% ordenacao(+L, -S) is semidet
%
%  Verdadeiro se S é a lista L com os elementos ordenados.

:- begin_tests(ordenacao).

test(ordenacao, S == [2, 3, 4, 7]) :-
    ordenacao([7, 2, 4, 3], S).

:- end_tests(ordenacao).

ordenacao(L, S) :-
    permutation(L, S),
    ordenado(S), !.


%% ordenado(+L) is semidet
%
%  Verdadeiro se L é uma lista de números ordenados.

ordenado([]).
ordenado([_]).
ordenado([A,B|R]) :-
    A =< B,
    ordenado([B|R]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercício 4.6

%% primo(?N) is nondet
%
%  Verdadeiro se N é um número primo. Quando N é uma variável, este predicado
%  gerar números primos.

:- begin_tests(primo).

test(primo7) :- primo(7).

test(primo8, fail) :- primo(8).

test(primo, all(N == [2, 3, 5, 7, 11, 13, 17, 19])) :-
    primo(N),
    ( N > 20, !, fail ; true).

:- end_tests(primo).


% N é primo se N é inteiro e não existe divisor de N entre 2 e N-1.
primo(N) :-
    integer(N), !,
    N0 is N - 1,
    \+((divisor(2, N0, _, N))).

% Gera todos os número primos começando com 2.
primo(N) :-
    entre(2, infinito, N),
    primo(N).


%% divisor(+A, +B, -D, +N) is nondet
%
%  Gera divisores D de N tal que A <= D <= B. D deve ser uma variável.

divisor(A, B, D, N) :-
    var(D),
    entre(A, B, D),
    divisivel(N, D).

%% entre(+A, +B, -N) is nondet
%
%  Gerar inteiros N tal que A <= N <= B. Se B = infinito, então gera inteiros N
%  tal que A <= N. N deve ser uma variável.
%  Veja o predicado pré-definido between/3.

:- begin_tests(entre).

test(entre, all(N == [3, 4, 5, 6, 7])) :-
    entre(3, 7, N).

:- end_tests(entre).

entre(_, _, N) :-
    nonvar(N), !, fail.

entre(A, infinito, A).
entre(A, infinito, N) :-
    A1 is A + 1,
    entre(A1, infinito, N).

entre(A, B, A) :-
    A =< B.
entre(A, B, N) :-
    A < B,
    A1 is A + 1,
    entre(A1, B, N).


%% divisivel(+N, +D) is semidet
%
%  Verdadeiro se N é divisível por D.

divisivel(N, D) :-
    N mod D =:= 0.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercício 4.8

zebra(N) :-
    % existe uma rua com três casa vizinhas
    Casa1 = casa(_, _, _), % cor, nacionalidade, animal
    Casa2 = casa(_, _, _),
    Casa3 = casa(_, _, _),
    Rua = [Casa1, Casa2, Casa3],
    % com cores diferentes
    member(casa(vermelho, _, _), Rua),
    member(casa(azul, _, _), Rua),
    member(casa(verde, _, _), Rua),
    % o inglês vive na casa vermelha
    member(casa(vermelho, ingles, _), Rua),
    % o espanhol tem como animal de estimação um jaguar
    member(casa(_, espanhol, jaguar), Rua),
    % o japonês vive ao lado de quem tem uma cobra
    ao_lado(Rua, casa(_, japones, _), casa(_, _, cobra)),
    % quem tem um cobra vive a esquerda da casa azul
    a_esquerda(Rua, casa(azul, _, _), casa(_, _, cobra)),
    % quem tem uma zebra
    member(casa(_, N, zebra), Rua).
    % writeln(Rua). % descomente a linha para ver a resposta completa

%% ao_lado(?L, ?A, ?B) is nondet
%
%  Verdadeiro se A aparece ao lado de B em L.
%  Exemplos
%  ?- ao_lado([1, 7, 4], 7, B).
%  B = 1 ;
%  B = 4 ;
%  false.

:- begin_tests(ao_lado).

test(ao_lado, all(T == [1, 4])) :-
    ao_lado([1, 7, 4], 7, T).

:- end_tests(ao_lado).

ao_lado([A,B|_], A, B).
ao_lado([A,B|_], B, A).
ao_lado([_|R], A, B) :-
    ao_lado(R, A, B).

%% a_esquerda(L, A, E) is nondet
%
%  Verdadeiro se E aparece a esquerda de A na lista L.
%  Exemplos
%  ?- a_esquerda([6, 4, 3, 8], 4, E).
%  E = 3 ;
%  E = 8 ;
%  false.

:- begin_tests(a_esquerda).

test(a_esquerda, all(E == [3, 8])) :-
    a_esquerda([6, 4, 3, 8], 4, E).

:- end_tests(a_esquerda).

a_esquerda([A|As], A, E) :-
    member(E, As).
a_esquerda([_|As], A, E) :-
    a_esquerda(As, A, E).

% vim: set ft=prolog spell spelllang=pt_br:
