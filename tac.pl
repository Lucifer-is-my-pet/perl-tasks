# $\ = "\n";

$fname = shift @ARGV;
open $text, '<', 'C:\Downloads\code.txt' or die "Something's wrong with your file, $!";
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
	if ($len != 1 or $lengths[-2] != 1) { # если текущая длина 1 и предыдущая длина один, не выводим
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

# foreach $n (@lengths) {
# 	if (length $n == 1)
#     print($n . " ");
# }