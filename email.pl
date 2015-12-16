$\ = "\n";
open $text, '<', $ARGV[0] or die "Something's wrong with your file, $!";

%emails = ();
while(<$text>) {
	$line = $_;
    $line =~ m%mailto:%g;
    $mailtoInd = $-[0];
    $line =~ m%"%g; # находит только одно вхождение, последнее
    $quoteInd = $-[0];
    $emailInd = $mailtoInd + length("mailto:");
    $email = substr($line, $emailInd, $quoteInd - $emailInd);
    $line =~ m%>%g;
    $greaterInd = $-[0] + 1;
    $line =~ m%<%g; # находит только одно вхождение, последнее
    $lessInd = $-[0];
    $name = substr($line, $greaterInd, $lessInd - $greaterInd);
    $emails{$email} = $name;
}

while(($key, $value) = each %emails) {
    print "$key => $value";
};