## Assembly Language - Fibonacci Sequence
Calculates a modified fibonacci number given a user-input index. Modified function `f(n) = f(n-1) + f(n-2) + f(n-3)`, with `f(1)=1, f(2)=1, f(3)=1`

### fib3_nonrecurs_full.asm
Full (main) asm file for a nonrecursive solution

### fib3_recursive_function.asm
Function with a global file, with a recursive solution


## changestr.asm
CSC231 HW 8

Prompts the user for a string of characters, changes the string in place: lowercase letters become uppercase, periods become exclamation marks; prints changed string back to console


## 4functions.asm
CSC231 HW 8

Creates four functions as follows:

  1. Receives address of string as well as its length, changes the string's characters in place from lowercase letters to uppercase
  
  2. Receives three 32-bit integers and computes `4*(a + b) + 3*c`, returning the result in `eax`
  
  3. Receives address of array as well as its length, returns in `eax` the number of negative numbers in the array
  
  4. Receives three 32-bit integers and returns the smallest of the three in `eax`
