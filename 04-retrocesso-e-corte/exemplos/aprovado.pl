%% aprovado(?A) is nondet
%
%  Verdadeiro se o aluno A foi aprovado.

:- begin_tests(aprovado).

test(t0, all(A == [jose, andre])) :-
    aluno(A),
    aprovado(A).

:- end_tests(aprovado).

aprovado(A) :-
    faltas(A, F),
    F > 25,
    !,
    fail.

aprovado(A) :-
    media(A, M),
    M >= 6, !.

aprovado(A) :-
    media(A, M),
    exame(A, E),
    (M + E)/2 >= 5.

aluno(jose).
aluno(paulo).
aluno(andre).

faltas(jose, 10).
faltas(paulo, 30).
faltas(andre, 0).

media(jose, 7).
media(paulo, 8).
media(andre, 4).

exame(andre, 6.5).
