$len = @ARGV;
$str = "";
if ($len == 1) {
	$answer = eval $ARGV[0];
} else {
	for $i(0 .. $len) {
		$str .= $ARGV[$i];
	}	
	$answer = eval $str;
}
	
print($answer);
	