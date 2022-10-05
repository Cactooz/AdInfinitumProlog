%Graphing system
edge(a,b).
edge(a,c).
edge(a,d).
edge(b,c).
edge(b,d).
edge(c,b).

selectS(X,[X|T],T).
selectS(X,[Y|T],[Y|R]) :- selectS(X,T,R).

%Check if a Node is a member of the List
memberchkS(Node,List) :- selectS(Node,List,_), !.

%Reverse the inputted list
reverse_list([],[]).
reverse_list([Head|Tail],R) :- reverse_list(Tail,RT), appendS(RT, [Head], R).

%:- Return all the paths from Start to End
%,  Since the visited are in the wrong order, it has to be reveresed
path(Start,End,Result) :- path(Start,End,[Start],Path), reverse_list(Path,Result).

%Basecase for Path for Start to Start
%The Path list becomes the visited, which are in the wrong order
path(Start,Start,Visited,Visited).

%:- Check if an edge exists from start to a node
%,  \+ = stop if the node exists in out visisted nodes list (from a potential loop)
%,  if it does not exsist in the visited nodes list, continue with the recrusion until the end is found
path(Start,End,Visited,Path) :- edge(Start,Node),
								\+ memberchkS(Node,Visited),
								path(Node,End,[Node|Visited],Path).
