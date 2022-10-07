%Get the length of a list
lengthS([],0).
lengthS([_|T],N) :- lengthS(T,N1), N is N1+1.

appendS([],L,L).
appendS([H|T],L,[H|R]) :- appendS(T,L,R).

%Get the parts of the list with numbers in order
split(List, Result) :- appendS(_, Part, List), appendS(Start, [End|_], Part), appendS(Start, [End], Result).

%Get the different parts and length of the list
partstring(List, L, F) :- split(List, F), lengthS(F, L).

/*
?- partstring([1,2,3,4], L, F)
appendS(_, Part, [1,2,3,4]) - Unify _ = [] and Part = [1,2,3,4]
appendS(Start, [End|_], Part) - Unify Start = [], [End|_] = [1,2,3,4] with End = 1
appendS(Start, [End], Result) - Append Start with [End] and add in result, like [] + [1] = [1]

In the next step, it finds for solutions in split using another Start
_ = [] and Part = [1,2,3,4]
Start = [1] and [End|_] = [2,3,4] where End = 2
[1] + [2] = [1,2]

After that it is still _ = [] but Start = [1,2] and so on
After all combinations for Start, it tests _ = [1] och gets
_ = [1] and Part = [2,3,4]
Start = [] and [End|_] = [2,3,4] where End = 2
[] + [2] = [2] 
*/
