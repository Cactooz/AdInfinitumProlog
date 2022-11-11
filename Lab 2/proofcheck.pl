% Base case
valid_proof(Premiss, Goal, Proof) :- member(Goal, Premiss).

% Base operations
and(X, Y) :- X, Y.

or(X, Y) :- X; Y.

neg(X) :- X, !, fail; true.

imp(X, Y) :- and(X, Y); neg(X).

% Verify the data from the inputted file
verify(InputFileName) :- see(InputFileName), read(Premiss), read(Goal),
						read(Proof), seen, valid_proof(Premiss, Goal, Proof).
