=head1 NAME
Reversed Polish Notation

=head1 SYNOPSIS
C<perl rpn.pl %math expression with spaces%>

=head1 USAGE
turns ordinary expression into RPN and returns the result

=head1 AUTHOR
Guralnik Darya

=head1 SUBROUTINES/METHODS
C<getPriority> returns priority of operator
=cut

$\ = "\n";
@priorities = (
   '()', '+-', '*/'
);

sub getPriority {
	for $i(0 .. @priorities) {
		if (index($priorities[$i], $_[0]) > -1) { # проверить index
			return $i;
		}
	}
}

@expressionArr = ();
# не может быть иначе, выражение подаётся с пробелами	
$expression = join("", @ARGV);
push @expressionArr, @ARGV;
$anwser1 = eval $expression;

$output = "";
@stack = ();

for $i(0 .. @expressionArr) {
	if ($expressionArr[$i] =~ m%\d%) {
		$output .= $expressionArr[$i] . " ";
	}
	elsif ($expressionArr[$i] =~ m%[\*]{2}%) { # право-ассоциированный
		push @stack, $expressionArr[$i];
	}
	elsif ($expressionArr[$i] =~ m%\(%) { # не должна оказаться в выходной строке
		push @stack, $expressionArr[$i];
	}
	elsif ($expressionArr[$i] =~ m%[\+\-\*/]%) {
		
		if (getPriority($expressionArr[$i]) <= getPriority($stack[-1])) {
			$tempOperator = pop @stack;
			$output .= $tempOperator . " ";
		}
		push @stack, $expressionArr[$i];
	}
	elsif ($expressionArr[$i] =~ m%\)%) { # пока верхним элементом стека не станет (,
											# выталкиваем элементы из стека в выходную строку.
											# ( удаляется из стека, но в выходную строку не добавляется
		$tempBrace = pop @stack;
		while (!($tempBrace =~ m%\(%)) {
			$output .= $tempBrace . " ";
			$tempBrace = pop @stack;
		}
	}
}
# когда входная строка закончилась, выталкиваем все символы из стека в выходную строку
while (@stack > 0) {
	$tempOperator = pop @stack;
	if (!((length $tempOperator) == 0)) {
		$output .= $tempOperator . " ";
	}	
}

print $output;
# 1.05 ** ( 1 + 2 ** 2 * 3 ** ( 4 * 2 - ( 5 + 3 ) / 4 * 2 ) )
# теперь у нас есть постфиксное выражение с пробелами
@splittedRPN = split (" ", $output);
$len = @splittedRPN;
@arr = ();
for $i(0 .. $len) {
	if ($splittedRPN[$i] =~ m/\d+/) {
		push @arr, $splittedRPN[$i];
	} else {
		$num2 = pop @arr;
		$num1 = pop @arr;
		if ($num1 < 0) {
			$num1 = "(" . $num1 . ")";
		}
		if ($num2 < 0) {
			$num2 = "(" . $num2 . ")";
		}
		$newNum = eval $num1 . $splittedRPN[$i] . $num2;
		
		push @arr, $newNum;
	}
}

print $arr[0];
print $anwser1; # для сравнения