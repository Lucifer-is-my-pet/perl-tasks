use strict;
use warnings;
use Data::Dumper;
use lib 'C:/Моё/Универ/Perl';
use FindBin qw( $RealBin );
use lib $RealBin;
use Matrix;

$\ = "\n";

my @arr = (
        [ 100, 200, 10 ],
        [ "george", "jane", "elroy" ],
        [ "homer", "marge", "bart" ],
);
my $neo;
eval {
    $neo = Matrix->new(\@arr);
};
if ($@) {
    print "Матрица не прямоугольная! " . $@;
} else {
    print $neo;
}
