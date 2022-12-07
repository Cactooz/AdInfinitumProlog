%Main predicates to read the proof file and validate the proof
%Verify the data from the inputted file
verify(Input) :- see(Input), read(T), read(L), read(S), read(F), seen, check(T, L, S, [], F).

%check(T, L, S, U, F)
%T - The transitions in form of adjacency lists
%L - The labeling
%S - Current state
%U - Currently recorded states
%F - CTL Formula to check.

%Special predicates to check all and some paths
%CHECKA - Check if the current and check all the other parts of the path.
checkA(_, _, [], _, _).
checkA(T, L, [S|Following], U, X) :- 
    check(T, L, S, U, X), 
    checkA(T, L, Following, U, X).

%CHECKE - Either the first path works or the one of the other
checkE(T, L, [S|Following], U, X) :- 
	check(T, L, S, U, X); 
	checkE(T, L, Following, U, X).

%Literals, "Normal" and NEG
check(_, L, S, [], X) :- 
	member([S, Conditions], L), 
	member(X, Conditions).
check(_, L, S, [], neg(X)) :-
	member([S, Conditions], L),
	not(member(X, Conditions)).

%AND - Check if X is correct and Y is correct
check(T, L, S, [], and(X,Y)) :- 
	check(T, L, S, [], X),
	check(T, L, S, [], Y).

%OR - first or rule is before/left of the ; and the second rule in after/right of the same ; 
check(T, L, S, [], or(X,Y)) :-
	check(T, L, S, [], X);
	check(T, L, S, [], Y).

%AX - Find the following states and checks if all of them is correct
check(T, L, S, [], ax(X)) :- member([S, States], T), 
    checkA(T, L, States, [], X).

%EX - Finds the following states and checkes if one of them is correct
check(T, L, S, [], ex(X)) :- member([S, States], T),
    checkE(T, L, States, [], X).

%AG1 - Check if S is in the U set, the loop is fullfilled
check(_, _, S, U, ag(_)) :- member(S, U).
%AG2 - Check that S is not in the loop, check rule,
%find all following states and check that all of them is correct
check(T, L, S, U, ag(X)) :-
	not(member(S, U)),
	check(T, L, S, [], X),
	member([S, States], T),
	checkA(T, L, States, [S|U], ag(X)).

%EG1 - Check if S is in the U set, the loop is fullfilled
check(_, _, S, U, eg(_)) :- member(S, U).
%EG2 - Check that S is not in the loop, check rule,
%find all following states and check that one of them is correct
check(T, L, S, U, eg(X)) :- 
    not(member(S, U)), 
    check(T, L, S, [], X),
	member([S, States], T), 
    checkE(T, L, States, [S|U], eg(X)).

%EF1 - Check that S is not in the loop, check rule, Base case
check(T, L, S, U, ef(X)) :- 
    not(member(S, U)), 
    check(T, L, S, [], X).
%EF2 - Check that S is not in the loop, find all following states,
%check if all of the following states if one of them is correct
check(T, L, S, U, ef(X)) :- 
    not(member(S, U)), 
    member([S, States], T), 
    checkE(T, L, States, [S|U], ef(X)).

%AF1 - Check that S is not in the loop, check rule, Base case
check(T, L, S, U, af(X)) :- 
    not(member(S, U)), 
    check(T, L, S, [], X).
%AF2 - Check that S is not in the loop, find all following states,
%check if all of the following states if all of them is correct
check(T, L, S, U, af(X)) :-
	not(member(S, U)),
	member([S, States], T),
	checkA(T, L, States, [S|U], af(X)).
