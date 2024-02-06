%% editor(P?, E?) is nondet
%
%  Verdadeiro se a pessoa P utiliza o editor de texto E.
editor(joao, vim).
editor(joao, emacs).
editor(pedro, emacs).
editor(maria, vim).


%% par(X?, Y?) is nondet
%
%  Verdadeiro se a pessoa X pode fazer um par para programação com a pessoa Y.
par(X, Y) :-
    editor(X, Z),
    editor(Y, Z),
    dif(X, Y).
