use strict;
$\ = "\n";
open my $text, '<', $ARGV[0] or die "Something's wrong with your file, $!";

my %emails = ();
while(<$text>) {
	my $line = $_;
    $line =~ m%mailto:%g;
    my $mailtoInd = $-[0];
    my @indexes = findAllIndexes($line, '"');
    my $quoteInd = $indexes[-1];
    my $emailInd = $mailtoInd + length("mailto:");
    my $email = substr($line, $emailInd, $quoteInd - $emailInd);

    @indexes = findAllIndexes($line, ">");
    my $greaterInd = $indexes[0] + 1;
    @indexes = findAllIndexes($line, "<");
    my $lessInd = $indexes[-1];
    my $name = substr($line, $greaterInd, $lessInd - $greaterInd);

    $emails{$email} = $name;
}

while((my $key, my $value) = each %emails) {
    print "$key => $value";
};

sub findAllIndexes {
    my $line = $_[0];
    my $pattern = $_[1];
    my @indexes = ();
    while ($line =~ /$pattern/g) {
        push @indexes, $-[0];
    }
    return @indexes;
}