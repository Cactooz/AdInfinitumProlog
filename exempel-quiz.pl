% Det här är en kort programkod som avser att definiera ett predikat
% ancestor(x,y) som anger om X är förfader (könsoberoende) till Y.
% Vi antar att ett predikat parent(x,y) redan är definierad.
% ancestor(X,Y) :- parent(X,Y)
% ---
% Vad ska stå på den sträckade raden?

parent(olle, bert).
parent(georg, olle).
parent(thomas, georg).

ancestor(X,Y) :- parent(X,Y).
% Hitta en förälder och sen leta upp dess föräldrar
ancestor(X,Y) :- parent(Z,Y), !, ancestor(X,Z).
