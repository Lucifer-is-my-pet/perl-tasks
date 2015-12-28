use strict;
use warnings;
use lib 'C:/Моё/Универ/Perl';
use FindBin qw( $RealBin );
use lib $RealBin;
use Matrix;

$\ = "\n";

# пример работы
my $neo;
my $duo;
eval {
    $neo = Matrix->new([[ 10, 20, 30 ],
        [ 10, 20, 30 ],
        [ 10, 20, 30 ]]);
    $duo = Matrix->new([[1], [1], [1]]);
};
if ($@) {
    print "Матрица не прямоугольная или " . $@;
} else {
    print $neo;
}
my $res;
eval {
    $res = $neo * $duo;
};
if ($@) {
    print "Матрицы разных размерностей или " . $@;
} else {
    print $res;
}
