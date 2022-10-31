% Base case
valid_proof(Premiss, Goal, Proof) :- member(Goal, Premiss).

%Verify the data from the inputted file
verify(InputFileName) :- see(InputFileName), read(Premiss), read(Goal),
						read(Proof), seen, valid_proof(Premiss, Goal, Proof).
