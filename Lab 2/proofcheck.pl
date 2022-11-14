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
goToLastLine([_|Tail], NextLine) :- goToLastLine(Tail, NextLine).

%Check if the last line of the proof is the goal
goalCheck(Proof, Goal) :- goToLastLine(Proof, R), member(Goal, R), !.


%Check if a line in the proof is correct and continue to the next line recursively
checkProof([], _, _).
checkProof([Head|Tail], Premise, Checked) :- ruleCheck(Head, Premise, Checked),
											addChecked(Head, Checked, NewChecked),
											checkProof(Tail, Premise, NewChecked).


%Check for premise
ruleCheck([_, Step, premise], Premise, _) :- member(Step, Premise).

%Check for andel1(X)
ruleCheck([_, Step, andel1(X)], _, Checked) :- member([X, and(Step, _), _], Checked).

%Check for andel2(X)
ruleCheck([_, Step, andel2(X)], _, Checked) :- member([X, and(_, Step), _], Checked).

%Check for impel(X,Y)
ruleCheck([_, Step, impel(X,Y)], _, Checked) :- member([X, Previous, _], Checked), member([Y, imp(Previous, Step), _], Checked).

%Check for negel(X)
ruleCheck([_, cont, negel(X,Y)], _, Checked) :- member([X, Step, _], Checked), member([Y, neg(Step), _], Checked).

%Check for contel(X)
ruleCheck([_, Step, contel(X)], _, Checked) :- member([X, cont, _], Checked).

%Check for negnegel(X)
ruleCheck([_, Step, negnegel(X)], _, Checked) :- member([X, neg(neg(Step)), _], Checked).

%Check for andint(X,Y)
ruleCheck([_, and(Part1, Part2), andint(X,Y)], _, Checked) :- member([X, Part1, _], Checked), member([Y, Part2, _], Checked).

%Check for orint1(X)
ruleCheck([_, or(Part, _), orint1(X)], _, Checked) :- member([X, Part, _], Checked).

%Check for orint2(X)
ruleCheck([_, or(_, Part), orint2(X)], _, Checked) :- member([X, Part, _], Checked).


%Check for negnegint(X)
ruleCheck([_, neg(neg(Step)), negnegint(X)], _, Checked) :- member([X, Step, _], Checked).

%Check for copy(X)
ruleCheck([_, Step, copy(X)], _, Checked) :- member([X, Step, _], Checked).

%Check for lem
ruleCheck([_, or(X,Y), lem], _, _) :- Y = neg(X). 

%Check for MT(X,Y)
ruleCheck([_, neg(Step), mt(X,Y)], _, Checked) :- member([X, imp(Step, Part), _], Checked), member([Y, neg(Part), _], Checked).


%Check an assumption start and go through the box
ruleCheck([[X, Step, assumption]|Box], Premise, Checked) :- addChecked([X, Step, assumption], Checked, NewChecked), checkProof(Box, Premise, NewChecked).

%Check for orel(X,A,B,C,D)
ruleCheck([_, Result, orel(X,A,B,C,D)], _, Checked) :- member([X, or(Part1, Part2), _], Checked), member(Box1, Checked), member(Box2, Checked),
													member([A, Part1, assumption], Box1), member([B, Result, _], Box1),
													member([C, Part2, assumption], Box2), member([D, Result, _], Box2).

%Check for impint
ruleCheck([_, imp(Start, End), impint(X,Y)], _, Checked) :- member(Box, Checked), member([X, Start, assumption], Box), member([Y, End, _], Box).

%Check for negint
ruleCheck([_, neg(Step), negint(X,Y)], _, Checked) :- member(Box, Checked), member([X, Step, assumption], Box), member([Y, cont, _], Box).

%Check for PBC(X,Y)
ruleCheck([_, Step, pbc(X,Y)], _, Checked) :- member(Box, Checked), member([X, neg(Step), assumption], Box), member([Y, cont, _], Box).
