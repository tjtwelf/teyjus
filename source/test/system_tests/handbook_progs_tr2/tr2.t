
use lib '../lib';
use strict;
use Test::More tests => 4;

my $TJSIM = "../../tjsim";
my $PATH = "--path handbook_progs_tr2/";
my $MODULE = "tr2_test";
my $code;
my $ans;

############################################
############################################
$code = <<'CODE';
test 1 F.

CODE
$ans = <<'ANS';

The answer substitution:
F = fix (W1\ abs (W2\ abs (W3\ cond (eq W2 (c 0)) W3 (app (app W1 (minus W2 (c 1))) (times W2 W3)))))

ANS
same_answers( `$TJSIM -b $PATH --solve "$code" $MODULE\n`, $ans,"test");
############################################
############################################
$code = <<'CODE';
test 2 F.

CODE
$ans = <<'ANS';

The answer substitution:
F = fix (W1\ abs (W2\ abs (W3\ cond (eq (c 1) W2) (c 1) (cond (lss W2 W3) (app (app W1 W3) W2) (cond (eq W2 W3) W2 (app (app W1 (minus W2 W3)) W3))))))

ANS
same_answers( `$TJSIM -b $PATH --solve "$code" $MODULE\n`, $ans,"test");
############################################
############################################
$code = <<'CODE';
test 3 F.

CODE
$ans = <<'ANS';

ANS
same_answers( `$TJSIM -b $PATH --solve "$code" $MODULE\n`, $ans,"test");
############################################
############################################
$code = <<'CODE';
test 4 F.

CODE
$ans = <<'ANS';

The answer substitution:
F = fix (W1\ abs (W2\ cond (&& (prp W2) (eq (fst W2) (c 0))) (snd W2) (cond (prp W2) (app W1 (pr (minus (fst W2) (c 1)) (times (fst W2) (snd W2)))) err)))


ANS
same_answers( `$TJSIM -b $PATH --solve "$code" $MODULE\n`, $ans,"test");
############################################
############################################
