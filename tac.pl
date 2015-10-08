=head1 NAME
tac

=head1 SYNOPSIS
C<perl tac.pl %filename%>

=head1 USAGE
prints lines of a %filename% from end to start

=head1 AUTHOR
Guralnik Darya

=head1 SUBROUTINES/METHODS
C<findPosition> returns position of '\n'
=cut

$fname = shift @ARGV;
open $text, '<', $fname or die "Something's wrong with your file, $!";

$fileSize = -s $text;
$position = $fileSize;
# print $fileSize;
@lengths = (); # костыль
while ($position > 0) {
	$position = &findPosition($position);
	seek($text, $position + 2, 0);
	$oneMoreText = readline($text);
	$len = length $oneMoreText;
	push @lengths, $len; 
	if ($len != 1 or $lengths[-2] != 1) { # если текущая длина 1 и предыдущая длина один, не выводим (патаму шта выводятся две пустые строки подряд там, где должна быть одна)
		print($oneMoreText);
	}
}

sub findPosition {
	$pos = shift;
	$char = "";
	seek($text, $pos - 1, 0);
	while ($char ne "\n" and $pos > 0) {
		$char = getc $text;
		seek($text, $pos - 1, 0);
		$pos = tell($text);
	}
	# print $pos;	
	return $pos;
}