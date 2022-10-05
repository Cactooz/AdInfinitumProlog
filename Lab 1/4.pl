%Graphing system
edge(a,b).
edge(a,c).
edge(a,d).
edge(b,c).
edge(b,d).
edge(c,b).

%Check if a path exsists from Start to End
path(Start,Start).
%path(Start,End) :- edge(Start,Node), path(Node,End).

%Check for paths without loops from Start to End
/*path(Start,Node) :- path(Start,End,[Start]).

path(Start,Start,Visited).
path(Start,End,Visited) :- edge(Start,Node),
						\+ singlemember(Node,Visited),
						path(Node,End,[Node|Visited]).*/

%Reverse the inputted list
reverse_list([],[]).
reverse_list([Head|Tail],R) :- reverse_list(Tail,RT), appendS(RT, [Head], R).

%Return all the paths from Start to End
path(Start,End,Result) :- path(Start,End,[Start],Path), reverse_list(Path,Result).

path(Start,Start,Visited,Visited).
path(Start,End,Visited,Path) :- edge(Start,Node),
							\+ singlemember(Node,Visited),
							path(Node,End,[Node|Visited],Path).

%Check for a single member in list
singlemember(Start,[Start|Node]) :- !.
singlemember(Start,[Node|End]) :- singlemember(Start,End).
