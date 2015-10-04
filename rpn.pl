$len = @ARGV;
if ($len > 1) {
	@arguments = @ARGV;
}
else {
	@arguments = split (/,/, $ARGV[0]);
}

$len = @arguments;
@arr = ();
for $i(0 .. $len) {
	if ($arguments[$i] =~ m/\d+/) {
		push @arr, $arguments[$i];
	} else {
		$num2 = pop @arr;
		$num1 = pop @arr;
		$newNum = eval $num1 . $arguments[$i] . $num2;
		push @arr, $newNum;
	}
}

print @arr[0];