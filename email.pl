use strict;

=head1 NAME
Finding emails and names

=head1 SYNOPSIS
C<perl email.pl %filename%>

=head1 USAGE
finds emails and corresponding names in given hypertext file and prints them

=head1 AUTHOR
Guralnik Darya
=cut

$\ = "\n";
open my $file, '<', $ARGV[0] or die "Something's wrong with your file, $!";

local $/;
my $text = <$file>;
my %emailsAndNames = ($text =~ /mailto:([^\s\>\<]+)">([^\>\<]+)</g);
while(my ($key, $value) = each %emailsAndNames) {
    print "$key => $value";
};