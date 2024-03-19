:- use_module(library(clpfd)).

%% natural(?N) is nondet
%
%  Verdadeiro se N é um número natural.
%
%  Exemplos
%  ?- natural(N).
%  N = 0 ;
%  N = 1 ;
%  N = 2 ;
%  ...

:- begin_tests(natural).

% Pergunta: como testar um gerador infinito?
% Resposta: usando corte com fail e ou ... Tente entender este teste.
test(t0, all(N == [0, 1, 2, 3])) :-
    natural(N),
    (N >= 4, !, fail ; true).

:- end_tests(natural).

natural(0).
natural(N) :-
    N #> 0,
    N #= N0 + 1,
    natural(N0).
