%------------------------------%
%Check for parent
%------------------------------%
dad(jonas,karl).
mum(jonas,karin).

%Check if dad or mum, then it is a parent
parent(X,Y) :- dad(X,Y); mum(X,Y).
%------------------------------%
%Get the inverse result
%------------------------------%
%If this isn't here we will always get false, since we have no false to invert to true, this is the base case
not(X).

%Create negation
not(X) :- X, !, fail.
%------------------------------%
%Loopup element
%------------------------------%
%Check if X is in the list
listpredikat(L,X) :- member(X,L).
%------------------------------%
%Remove last element
%------------------------------%
%Remove last element, base case - return nothing if only one elemnt is left
removelast([X],[]).

%If the list is [1,2,3], then head = [1] and tail = [2,3]
%:- Recrusive going down to where only the last element is left with an empty list, going back readding the previous elements
removelast([Head|Tail],[Head|R1]) :- removelast(Tail,R1).
%------------------------------%
%Permutation of list
%------------------------------%
%Give all permutations of a list, base case - if the list is empty return empty
permute([],[]).

%:- Returns a list where X is removed from the original list
%, Permute the remaining parts of the list
%% ; append([X],R2,R3) can be used in the end along with the start permute(List,R3) instead of permute(List, [X|R2])
permute(L,[X|R2]) :- select(X,L,R1), permute(R1,R2).
%------------------------------%
%Height of tree
%------------------------------%
% Base case for a node, number, left and right
node(tal, L, R).

/*Set up the tree
    1
   / \
  2   5
 / \   \
3   4   6
       / \
      7   8*/
node(1,node(2,node(3,nil,nil),node(4,nil,nil)),node(5,nil,node(6,node(7,nil,nil),node(8,nil,nil)))).

%Gets the biggest value of M and N 
max(M,N,R) :- M>=N, !, R is M; R is N.

%If the are no nodes, then 0 height, base case
height(nil,0).

%Get the height of the tree
%:- check the height recrusivly of the left branch
%, check the same with the right branch
%,, get the max value of the two branches
%,,, add one to the result, so it includes the root level
height(node(N,L,R),Ret) :- height(L,HL), height(R,HR), max(HL,HR,HMax), Ret is HMax+1.
%------------------------------%
