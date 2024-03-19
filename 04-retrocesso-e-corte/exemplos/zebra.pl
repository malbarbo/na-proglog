%% desafio(?Casa1, ?Casa2, ?Casa3) is semidet
%
%  Vedadeiro se Casa1, Casa2 e Casa3 são estruturas da forma casa(C, N, A),
%  onde C é uma cor, N e uma nacionalidade e A é um animal, que atendem as
%  restrições do seguinte problema de lógica.
%
%  Existe uma rua com três casas vizinhas com cores diferentes (vermelho, azul
%  e verde). Em cada casa vive uma pessoa de uma nacionalidade diferente e que
%  têm uma animal de estimação diferente. Mais alguns fatos sobre as casas:
%
%  - O inglês vive na casa vermelha.
%  - O espanhol tem como animal de estimação um jaguar.
%  - O japonês vive ao lado de quem tem uma cobra.
%  - Quem tem um cobra vive a esquerda da casa azul.
%  - Alguém tem uma zebra
%
%  Você pode verificar a solução para esse problema fazendo a consulta
%  desafio(Casa1, Casa2, Casa3).

desafio(Casa1, Casa2, Casa3) :-
    % existe uma rua com três casa vizinhas
    Rua = [Casa1, Casa2, Casa3],
    Casa1 = casa(_, _, _), % cor, nacionalidade, animal
    Casa2 = casa(_, _, _),
    Casa3 = casa(_, _, _),
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
    % alguém tem uma zebra
    member(casa(_, _, zebra), Rua).

%% ao_lado(?L, ?A, ?B) is nondet
%
%  Verdadeiro se A aparece ao lado de B na lista L.
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
