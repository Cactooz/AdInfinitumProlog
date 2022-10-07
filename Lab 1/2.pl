selectS(X,[X|T],T).
selectS(X,[Y|T],[Y|R]) :- selectS(X,T,R).

appendS([],L,L).
appendS([H|T],L,[H|R]) :- appendS(T,L,R).

%Check if the element is a member of the list
memberS(X,L) :- selectS(X,L,_).

%Reverse the inputted list
reverse_list([],[]).
reverse_list([Head|Tail],R) :- reverse_list(Tail,RT), appendS(RT, [Head], R).

%Reverse the list, then remove elements and then reverse it again to keep the original order
remove_duplicates([Head|Tail], R) :- reverse_list([Head|Tail], R1), remove_elements(R1, R2), reverse_list(R2,R).

%Remove all duplicate elements, checking with head and removing it if the tail has it
remove_elements([],[]).

%Remove the head if it exsists in the tail,
%stop backtracking since the recursion takes care of removing the rest of the duplicates
remove_elements([Head|Tail],R) :- memberS(Head,Tail), !, remove_elements(Tail, R).

%If the head does not exsist
%Go in another step in the list and do the same task, using recrusion
remove_elements([Head|Tail],[Head|R]) :- remove_elements(Tail, R).
