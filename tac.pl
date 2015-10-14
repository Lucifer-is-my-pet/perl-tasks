=head1 NAME
tac

=head1 SYNOPSIS
C<perl tac.pl %filename%>

=head1 USAGE
prints lines of a %filename% from end to start

=head1 AUTHORP
Guralnik Darya

=head1 SUBROUTINES/METHODS
C<findPosition> returns position of '\n'
=cut

$fname = shift @ARGV;
open $text, '<', $fname or die "Something's wrong with your file, $!";

$fileSize = -s $text;
$position = $fileSize;
# print $fileSize;
$currLen = 0;
$lastLen = 0;
while ($position > 0) {
	$position = &findPosition($position);
	if ($position != 0) {
		seek($text, $position + 2, 0);
	}
	else {
		seek($text, $position, 0);
	}	
	$oneMoreText = readline($text);
	$currLen = length $oneMoreText;
	if ($currLen != 1 or $lastLen != 1) { # если текущая длина 1 и предыдущая длина один,
										  # не выводим (так как выводятся две пустые строки подряд там, где должна быть одна)
		print($oneMoreText);
	}
	$lastLen = $currLen;
}

sub findPosition {
	$pos = shift;
	$char = "";
	seek($text, $pos - 1, 0);
	while ($char ne "\n" and $pos > 0) {
		$char = getc $text;
		seek($text, $pos - 1, 0);
		$pos -= 1;
	}
	# print $pos;	
	return $pos;
}