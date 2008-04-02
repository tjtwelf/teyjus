/*
 * Interface to the implementation of a set of primitive tactics
 * for a fragment of first-order logic. Judgements pair formulas 
 * with proofs. Basic goals represent a relationship between a list 
 * of judgements and a judgement.
 */

sig  ndtac. 

accum_sig goaltypes, ndproofs, logic.

kind    judgment	type.
kind    answer		type.

type    of_type		proof_object -> bool -> judgment.
type    -->		(list judgment) -> judgment -> goal.

type	yes		answer.

type	exists_e_tac	int -> goal -> goal -> o.
type	or_e_tac	int -> goal -> goal -> o.
type	forall_e_query	int -> goal -> goal -> o.
type	forall_e_tac	int -> goal -> goal -> o.
type	fchain_tac	int -> goal -> goal -> o.
type	bchain_tac	int -> goal -> goal -> o.
type	imp_e_retain	int -> goal -> goal -> o.
type	imp_e_tac	int -> goal -> goal -> o.
type	and_e_tac	int -> goal -> goal -> o.
type	exists_i_query	goal -> goal -> o.
type	exists_i_tac	goal -> goal -> o.
type	forall_i_tac	goal -> goal -> o.
type	imp_i_tac	goal -> goal -> o.
type	or_i2_tac	goal -> goal -> o.
type	or_i1_tac	goal -> goal -> o.
type	and_i_tac	goal -> goal -> o.
type	close_tacn	int -> goal -> goal -> o.
type	close_tac	goal -> goal -> o.

infix   of_type 120.
infix   --> 110.
