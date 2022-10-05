%Get the length of a list
lengthS([],0).
lengthS([_|T],N) :- lengthS(T,N1), N is N1+1.

appendS([],L,L).
appendS([H|T],L,[H|R]) :- appendS(T,L,R).

%Get the parts of the list with numbers in order
split(List, Result) :- appendS(_, Part, List), appendS(Start, [End|_], Part), appendS(Start, [End], Result).

%Get the different parts and length of the list
partstring(List, L, F) :- split(List, F), lengthS(F, L).
