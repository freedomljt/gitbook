# Dockerfile 语法

## if then if, if then elif fi, if then else fi

### demo

```javascript
if [ confition ]
then
    block_of_statements
fi
```

### Numeric and StringComparison

```javascript
age=21
if [ $age -gt 18 ]
then
  echo "You are old enough to drive in most places."
fi
```

| Numeric Comparison  | Returns true (0) if:                  |
| :------------------ | :------------------------------------ |
| [ $num1 -eq $num2 ] | num1 equals num2                      |
| [ $num1 -ne $num2 ] | num1 does not equal num2              |
| [ $num1 -lt $num2 ] | num1 is less than num2                |
| [ $num1 -gt $num2 ] | num1 is greater than num2             |
| [ $num1 -le $num2 ] | num1 is less than or equal to num2    |
| [ $num1 -ge $num2 ] | num1 is greater than or equal to num2 |

```javascript
name=John
if [ $string = "John" ]
then
  echo "John is here !!!"
fi

```

| String Comparison | Returns true (0) if:                                     |
| :---------------- | :------------------------------------------------------- |
| [ str1 = str2 ]   | str1 equals str2                                         |
| [ str1 != str2 ]  | str1 does not equal str2                                 |
| [ str1 < str2 ]   | str1 precedes str2 in lexical order                      |
| [ str1 > str2 ]   | str1 follows str2 in lexical order                       |
| [ -Z str1 ]       | str1 has length zero (holds null value)                  |
| [ -nstr1 ]        | str1has nonzero length (contains one or more characters) |


### if then else statement

```javascript
if [ condition ]
then
    block_of_statements
else
    block_of_statements
fi
```

```javascript
total=100
if [ $total -eq 100 ]; then
 echo "total is equal to 100"
else
 echo "total is not equal to 100"
fi

```

### if/then/elif/else statement

```javascript
if [ condition 1 ]  
then
	block_of_statements 
elif [ condition 2 ] 
then
	block_of_statements
else 
	block_of_statements
fi
```

```javascript
total=100
if [ $total -eq 100 ]
then
 echo "total is equal to 100"
elif [ $total -lt 100 ]
then
 echo "total is less than 100"
else
 echo "total is greater than 100"
fi

```

```javascript
name=snoopy

if [ "$name" = "snoopy" ] then
	echo "It was a dark and stormy night."
elif [ "$name" == "charlie" ]
then
	echo "You’re a good man Charlie Brown."
elif [ "$name" == "lucy" ]
then
	echo "The doctor is in."
elif [ "$name" == "schroeder" ]
then
	echo "In concert." 
else
	echo "Not a Snoopy character."
fi
```

### Nested if statements

```javascript
if [ $# -ne 1 ] 
then
	echo "You need to enter the year."
	exit 1 
fi

year=$1

if [ $[$year % 400] -eq "0" ]
then
	echo "$year is a leap year!" 
elif [ $[$year % 4] -eq 0 ]
then
	if [ $[$year % 100] -ne 0 ]
	then
		echo "$year is a leap year!"
	else
		echo "$year is not a leap year."
	fi
else
	echo "$year is not a leap year."
fi
```

### Multiple conditions in if loop (Boolean Operators)

```javascript
num=150
if [ $num -gt 100 ] && [ $num -lt 200 ]
then
	echo "The number lies between 100 and 200"
fi
```