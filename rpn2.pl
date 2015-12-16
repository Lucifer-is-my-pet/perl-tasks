=head1 NAME
Reversed Polish Notation

=head1 SYNOPSIS
C<perl rpn.pl %math expression with or without spaces%>

=head1 USAGE
turns ordinary infix expression into RPN and returns the results of both of them

=head1 AUTHOR
Guralnik Darya

=head1 SUBROUTINES/METHODS
C<stringToArr> turns input string into array of operators and operands
=cut

$\ = "\n";

%priority = ('(' => 0, ')' => 0, '+' => 1, '-' => 1, '*' => 2, '/' => 2, '**' => 3);

@expressionArr = ();
if (@ARGV == 1) {
	$input = @ARGV[0];
	@expressionArr = stringToArr($input);
} else {
	push @expressionArr, @ARGV;
}
$expression = join("", @ARGV);
$anwser1 = eval $expression;

$output = "";
@stack = ();

for my $expr(@expressionArr) {
	if ($expr =~ m%\d%) {
		$output .= $expr . " ";
	}
	elsif ($expr =~ m%[\*]{2}%) { # право-ассоциированный
		push @stack, $expr;
	}
	elsif ($expr =~ m%\(%) { # не должна оказаться в выходной строке
		push @stack, $expr;
	}
	elsif ($expr =~ m%[\+\-\*/]%) {
		
		if ($priority{$expr} <= $priority{$stack[-1]}) {
			$tempOperator = pop @stack;
			$output .= $tempOperator . " ";
		}
		push @stack, $expr;
	}
	elsif ($expr =~ m%\)%) { # пока верхним элементом стека не станет (,
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

print "postfix: " . $output;

# теперь у нас есть постфиксное выражение с пробелами
@splittedRPN = split (" ", $output);
@arr = ();
for my $elem(@splittedRPN) {
	if ($elem =~ m/\d+/) {
		push @arr, $elem;
	} else {
		$num2 = pop @arr;
		$num1 = pop @arr;

		if ($elem eq "+") {
			$newNum = $num1 + $num2;
		} elsif ($elem eq "-")  {
			$newNum = $num1 - $num2;
		} elsif ($elem eq "*") {
			$newNum = $num1 * $num2;
		} elsif ($elem eq "/") {
			$newNum = $num1 / $num2;
		} elsif ($elem eq "**") {
			$newNum = $num1 ** $num2;
		}
		# print $newNum, " from ", $num1, " ", $num2;
		push @arr, $newNum;
	}
}

print "infix result: " . $anwser1;
print "postfix result: " . $arr[0];

sub stringToArr {
	split /(\*\*|\D)/, shift;
	# хоть и длинный, зато свой и понятный
	# @result = ();
	# $number = "";
	# $deg = "";
	# for my $elem(split (//, $_[0])) { # элемент - число или операнд
	# 	if ($elem =~ m%\d%) {
	# 		$number .= $elem;
	# 		if (length $deg) { # отлавливаем умножение
	# 			push @result, $deg;
	# 			$deg = "";
	# 		}
	# 	} elsif ($elem eq "*") { # возможен операнд из двух знаков
	# 		if (length $deg) {
	# 			if (length $number) {
	# 				push @result, $number;
	# 				$number = "";
	# 			}
	# 			push @result, "**";
	# 			$deg = "";
	# 		} else {
	# 			$deg = "*";
	# 			if (length $number) {
	# 				push @result, $number;
	# 				$number = "";
	# 			}
	# 		}
	# 	} else {
	# 		if ($elem =~ m%[^+\-\(\)/]%) {
	# 			die "Wrong operator ", $elem;
	# 		}
	# 		if (length $number) {
	# 			push @result, $number;
	# 			$number = "";
	# 		}
	# 		push @result, $elem;
	# 	}
	# }
	# push @result, $number; # последнее число в ходе цикла не добавляется
	# # print(join ",", @result);
	# return @result;
}