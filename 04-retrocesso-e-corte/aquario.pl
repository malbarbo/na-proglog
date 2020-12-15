:- use_module(library(clpfd)).

%% aquario(?C1, ?C2, ?C3, ?C4) is nondet
%
%  Verdadeiro se C1, C2, C3 e C4 são termos crianca(Nome, Idade, Animal, Lanche)
%  que atendem as restrições do seguinte problema de lógica.
%
% Visita ao Aquário
%
% Quatro crianças estão visitando o aquário pela primeira vez. Siga as dicas e
% descubra qual animal cada uma quer ver:
%  1) Nem a criança que quer ver o peixepalhaço nem a que quer ver o tubarão levou bolacha.
%  2) Quem levou sanduíche é 1 ano mais novo que a criança que quer ver o peixepalhaço.
%  3) A criança que levou fruta é 1 ano mais nova do que quem deseja ver o tubarão.
%  4) Danilo é 2 anos mais velho do que a criança que levou fruta.
%  5) Alan não tem 6 anos.
%  6) A criança que levou salgadinho quer ver o tubarão.
%  7) Quem deseja ver o tubarão é o Renan ou o menino de 9 anos.
%  8)Quem levou sanduíche tem 8 anos ou quer ver o leão-marinho.

aquario(C1, C2, C3, C4) :-
    % Quadro crianças estão visitando o aquário
    Criancas = [C1, C2, C3, C4],
    % O nome das crianças são
    % Aqui definimos as "ordem" das crianças para não termos mais que uma reposta
    C1 = crianca(alan, _, _, _),
    C2 = crianca(danilo, _, _, _),
    C3 = crianca(elias, _, _, _),
    C4 = crianca(renan, _, _, _),
    % As idades das crianças são
    member(crianca(_, 6, _, _), Criancas),
    member(crianca(_, 7, _, _), Criancas),
    member(crianca(_, 8, _, _), Criancas),
    member(crianca(_, 9, _, _), Criancas),
    % Os animais que as crianças querem ver são
    member(crianca(_, _, leao_marinho, _), Criancas),
    member(crianca(_, _, peixe_palhaco, _), Criancas),
    member(crianca(_, _, tartaruga, _), Criancas),
    member(crianca(_, _, tubarao, _), Criancas),
    % Os lanches que as crianças estão levando são
    member(crianca(_, _, _, bolacha), Criancas),
    member(crianca(_, _, _, fruta), Criancas),
    member(crianca(_, _, _, salgadinho), Criancas),
    member(crianca(_, _, _, sanduiche), Criancas),
    % Nem a criança que quer ver o peixepalhaço nem a que quer ver o tubarão levou bolacha.
    quer_ver(Criancas, QuerVerPeixe, peixe_palhaco),
    quer_ver(Criancas, QuerVerTubarao, tubarao),
    QuerVerPeixe \= crianca(_, _, _, bolacha),
    QuerVerTubarao \= crianca(_, _, _, bolacha),
    % Quem levou sanduíche é 1 ano mais novo que a criança que quer ver o peixe­palhaço.
    mais_novo(Criancas, crianca(_, _, _, sanduiche), crianca(_, _, peixe_palhaco, _), 1),
    % A criança que levou fruta é 1 ano mais nova do que quem deseja ver o tubarão.
    mais_novo(Criancas, crianca(_, _, _, fruta), crianca(_, _, tubarao, _), 1),
    % Danilo é 2 anos mais velho do que a criança que levou fruta.
    % Reescrevendo: a criança que levou fruta é dois anos mais nova que o Danilo
    mais_novo(Criancas, crianca(_, _, _, fruta), crianca(danilo, _, _, _), 2),
    % Alan não tem 6 anos.
    member(crianca(alan, IdadeAlan, _, _), Criancas),
    IdadeAlan #\= 6,
    % A criança que levou salgadinho quer ver o tubarão.
    member(crianca(_, _, tubarao, salgadinho), Criancas),
    % Quem deseja ver o tubarão é o Renan ou o menino de 9 anos.
    (member(crianca(renan, _, tubarao, _), Criancas) ;
        member(crianca(_, 9, tubarao, _), Criancas)),
    % Quem levou sanduíche tem 8 anos ou quer ver o leão-marinho.
    (member(crianca(_, 8, _, sanduiche), Criancas) ;
        member(crianca(_, _, leao_marinho, sanduiche), Criancas)).


%% quer_ver(?Criancas, ?C, ?A) is nondet
%
%  Verdadeiro se C está na lista Criancas e quer ver o animal A

:- begin_tests(quer_ver).

test(t1, nondet) :-
    A = crianca(_, _, peixe, _),
    B = crianca(_, _, arraia, _),
    quer_ver([A, B], A, peixe),
    quer_ver([A, B], B, arraia).

test(t2, all(N == [peixe, arraia])) :-
    A = crianca(_, _, peixe, _),
    B = crianca(_, _, arraia, _),
    quer_ver([A, B], crianca(_, _, _, _), N).

:- end_tests(quer_ver).

quer_ver(Criancas, C, A) :-
    C = crianca(_, _, A, _),
    member(C, Criancas).


%% mais_novo(?Criancas, ?C1, ?C2, ?A) is nondet
%
%  Verdadeiro se C1 e C2 estão na lista Criancas e
%  a criança C1 é A anos mais nova que a criança C2.

:- begin_tests(mais_novo).

test(t3, nondet) :-
    A = crianca(jose, 1, _, _),
    B = crianca(pedro, 3, _, _),
    mais_novo([A, B], A, B, 2).

test(t4, I == 4) :-
    A = crianca(jose, I, _, _),
    B = crianca(pedro, 5, _, _),
    mais_novo([A, B], A, B, 1), !.

:- end_tests(mais_novo).

mais_novo(Criancas, C1, C2, A) :-
    C1 = crianca(_, I1, _, _),
    C2 = crianca(_, I2, _, _),
    I1 #= I2 - A,
    member(C1, Criancas),
    member(C2, Criancas).
