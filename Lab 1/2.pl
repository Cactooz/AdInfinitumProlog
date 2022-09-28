selectS(X,[X|T],T).
selectS(X,[Y|T],[Y|R]) :- selectS(X,T,R).

memberS(X,L) :- selectS(X,L,_).

notS(X).

notS(X) :- X, !, fail.

remove_first([Head|Tail],Tail).

remove_duplicates([],[]).

remove_duplicates([Head|Tail],R) :- memberS(Head,Tail), remove_duplicates(Tail, R).
remove_duplicates([Head|Tail],[Head|R]) :- remove_duplicates(Tail, R).
