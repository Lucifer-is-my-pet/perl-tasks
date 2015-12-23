use strict;

=head1 NAME
Sort

=head1 SYNOPSIS
C<perl sort.pl %filename%>

=head1 USAGE
returns number of repeates for every word in given file in descending order

=head1 AUTHOR
Guralnik Darya

=head1 SUBROUTINES/METHODS
C<fillTheDammitHash> fills passed hash with new keys-words from passed array or increases their values
=cut

$\ = "\n";
open my $text, '<', $ARGV[0] or die "Something's wrong with your file, $!";

my %hashOfRepeats = ();

while (my $line = <$text>) {
	$line =~ s/[.,;\(\)"]//g;
	my @splittedLine = split /\s/, $line;
	fillTheDammitHash(\%hashOfRepeats, \@splittedLine);
};

for my $key (sort { $hashOfRepeats{$b} <=> $hashOfRepeats{$a} } keys %hashOfRepeats) {
    print $key, " => ", $hashOfRepeats{$key};
}

sub fillTheDammitHash {
    my ($href, $words) = @_;
    for my $word(@$words) {
        if (exists $$href{lc $word}) { # забиваем на регистр
            $$href{lc $word} += 1;
        }
        else {
            $$href{lc $word} = 1;
        }
    }
}