% Base operations
and(X, Y) :- X, Y.

or(X, Y) :- X; Y. 

neg(X) :- X, !, fail; true.

imp(X, Y) :- and(X, Y); neg(X).


%Verify the data from the inputted file
verify(InputFileName) :- see(InputFileName), read(Premise), read(Goal),
						read(Proof), seen, validProof(Premise, Goal, Proof).

%Check if the goal and proof is valid
%validProof(Premise, Goal, Proof) :- member(Goal, Premise).
validProof(Premise, Goal, Proof) :- goalCheck(Proof, Goal), checkProof(Proof, Premise, []), !.


%Append line to end of list
appendLast(X, [], [X]).
appendLast(A, [Head|Tail], [Head|R]) :- appendLast(A, Tail, R).

%Adds the checked line to the checked list
addChecked(Line, Old, New) :- appendLast(Line, Old, New).


%Go to the last line in the proof
goToLastLine([X], X).
goToLastLine([Head|Tail], NextLine) :- goToLastLine(Tail, NextLine).

%Check if the last line of the proof is the goal
goalCheck(Proof, Goal) :- goToLastLine(Proof, R), member(Goal, R), !.


%Check if a line in the proof is correct and continue to the next line recursively
checkProof([], _, _).
checkProof([Head|Tail], Premise, Checked) :- ruleCheck(Head, Premise, Checked),
											addChecked(Head, Checked, NewChecked),
											checkProof(Tail, Premise, NewChecked).


%Check for premise
ruleCheck([_, Step, premise], Premise, _) :- member(Step, Premise).
