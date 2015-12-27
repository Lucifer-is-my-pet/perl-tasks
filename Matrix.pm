package Matrix;
use strict;
use warnings;
use Data::Dumper 'Dumper';

use overload '""' => \&toString, '*' => \&multiply;

sub new {
    my ($class, $args) = @_;
    checkForRect(@$args);
    my $self = {
        name => "Matrix",
        matrix => [@$args]
    };
    bless $self, $class;
    return $self;
}

sub checkForRect {
    my @arrayToCheck = @_;
    my $prevLength = scalar(@{$arrayToCheck[0]});
    for my $i (1 .. $#arrayToCheck) {
        if ($prevLength != scalar(@{$arrayToCheck[$i]})) {
            die "Error";
        }
    }
}

sub toString {
    my ($self) = @_;
    print Dumper($self->{matrix});
    my $printString = "";
    for my $i (0 .. $#{$self->{matrix}}) {
        $printString .= "[ ";
        my $lastIndex = $#{${$self->{matrix}}[$i]};
        for my $j (0 ..  $lastIndex) {
            $printString .= "${${$self->{matrix}}[$i]}[$j]";
            if ($j != $lastIndex) {
                $printString .= ", ";
            }
        }
        $printString .= " ]\n";
    }
    return $printString;
}

1;