### Task 1: For Loop
1. Create `for_loop.sh` that:
   - Loops through a list of 5 fruits and prints each one


```
#!/bin/bash

fruits=("banana" "pineapple" "apple" "pomegranate" "orange")

for i in "${fruits[@]}"; do
    echo "$i"
done
```
**Output**

banana
pineapple
apple
pomegranate
orange


2. Create `count.sh` that:
   - Prints numbers 1 to 10 using a for loop

```
#!/bin/bash

for ((i=1; i<=10; i++)); do
	
	echo $i

done
```
**Output**
```
1
2
3
4
5
6
7
8
9
```
---

### Task 2: While Loop
1. Create `countdown.sh` that:
   - Takes a number from the user
   - Counts down to 0 using a while loop
   - Prints "Done!" at the end

**Answer**

```
#!/bin/bash

read -p "Enter a number to countdown: " number

while [ $number -gt 0 ]; do
        ((number=$number -1))

        echo $number

done

echo "Done!"
```
**Output**
```
Enter a number to countdown: 8
7
6
5
4
3
2
1
0
Done!
```
### Task 3: Command-Line Arguments
1. Create `greet.sh` that:
   - Accepts a name as `$1`
   - Prints `Hello, <name>!`
   - If no argument is passed, prints "Usage: ./greet.sh <name>"

**Answer**

```
#!/bin/bash

echo "Hello" $1

if [ "$1" == "" ] ; then
        echo "Usage: ./greet.sh <name>"
elif
        echo "Hello" $1;
fi
```
**Output**
```
Usage: ./greet.sh <name>
```
2. Create `args_demo.sh` that:
   - Prints total number of arguments (`$#`)
   - Prints all arguments (`$@`)
   - Prints the script name (`$0`)
**Answer**
```
#!/bin/bash

echo "Total number of arguments: $#"
echo "All arguments: $@"
echo "The script name: $0"

```

**Output**
```
$ ./args_demo.sh apple banana orange
Total number of arguments: 3
All arguments: apple banana orange
The script name: ./args_demo.sh
```




