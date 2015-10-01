$len = @ARGV;
$str = join("", @ARGV);
$answer = eval $str;
print($answer);
