selectS(X,[X|T],T).
selectS(X,[Y|T],[Y|R]) :- selectS(X,T,R).

%Get the length of a list
lengthS([],0).
lengthS([_|T],N) :- lengthS(T,N1), N is N1+1.

%Give all permutations of a list
permute([],[]).
permute(L,[X|R2]) :- selectS(X,L,R1), permute(R1,R2).

%Get the permutations and length of the list
partstring(List, Length, F) :- permute(List,F), lengthS(F,Length).
