selectS(X,[X|T],T).
selectS(X,[Y|T],[Y|R]) :- selectS(X,T,R).

%Check if the element is a member of the list
memberS(X,L) :- selectS(X,L,_).

%Reverse the inputted list
reverse_list([],[]).
reverse_list([Head|Tail],R) :- reverse_list(Tail,RT), append(RT, [Head], R).

%Reverse the list, then remove elements and then reverse it again to keep the original order
remove_duplicates([Head|Tail], R) :- reverse_list([Head|Tail], R1), remove_element(R1, R2), reverse_list(R2,R).

%Remove all duplicate elements, checking with head and keeping head
remove_element([],[]).
remove_element([Head|Tail],R) :- memberS(Head,Tail), remove_element(Tail, R).
remove_element([Head|Tail],[Head|R]) :- remove_element(Tail, R).
