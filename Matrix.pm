package Matrix;
use strict;
use warnings;
use Data::Dumper 'Dumper';

use overload '""' => \&toString, '*' => \&multiply;

sub new {
    my ($class, $arg) = @_;
    if (!$arg) {
        @$arg = undef;
    } else {
        checkForRect(@$arg);
    }
    my $self = {
        matrix => [@$arg]
    };
    bless $self, $class;
    return $self;
}

sub checkForRect {
    my @arrayToCheck = @_;
    if (@arrayToCheck) {
        my $prevLength = scalar(@{$arrayToCheck[0]});
        for my $i (1 .. $#arrayToCheck) {
            if ($prevLength != scalar(@{$arrayToCheck[$i]})) {
                die "Error";
            }
        }
    }
}

sub toString {
    my ($self) = @_;
    my $printString = "";
    for my $i (0 .. $#{$self->{matrix}}) {
        $printString .= "[ ";
        my $lastIndex = $#{$self->{matrix}->[$i]};
        for my $j (0 ..  $lastIndex) {
            $printString .= "$self->{matrix}->[$i]->[$j]";
            if ($j != $lastIndex) {
                $printString .= ", ";
            }
        }
        $printString .= " ]\n";
    }
    return $printString;
}

sub multiply {
    my ($self, $other) = @_;
    my $selfRowLen = @{$self->{matrix}} - 1;
    my $otherRowLen = @{$other->{matrix}} - 1;
    my $selfColLen = @{$self->{matrix}->[0]} - 1;
    my $otherColLen = @{$other->{matrix}->[0]} - 1;
    if ($selfColLen != $otherRowLen) {
        die "Error";
    }
    my $res = new("Matrix");
    my @result = ();
    for my $i (0 .. $selfRowLen) {
        for my $j (0 .. $otherColLen) {
            $result[$i][$j] = 0;
        }
    }
    for my $i (0 .. $selfRowLen) {
        for my $j (0 .. $otherColLen) {
            for my $k (0 .. $selfColLen) {
                $result[$i][$j] += $self->{matrix}->[$i]->[$k] * $other->{matrix}->[$k]->[$j];
            }
        }
    }
    $res->matrix(\@result);
    return $res;
}

sub matrix {
    my $self = shift;
	$self->{matrix} = shift if @_ == 1;
	return $self->{matrix};
}

1;