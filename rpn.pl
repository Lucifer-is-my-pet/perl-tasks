$len = @ARGV;
@arr = ();
for $i(0 .. $len) {
	if ($ARGV[$i] =~ m/\d+/) {
		push @arr, $ARGV[$i];
	} else {
		$num2 = pop @arr;
		$num1 = pop @arr;
		$newNum = eval $num1 . $ARGV[$i] . $num2;
		push @arr, $newNum;
	}
}
print @arr[0];