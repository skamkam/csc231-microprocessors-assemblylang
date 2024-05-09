`char_decoder.asm`

Reads in 32-bit unsigned integer from user. Stores integer as RAM at label `x`, defined as `dd`; decrypts the four bytes at labels `x`, `x+1`, `x+2`, `x+3` as follows:

  * Byte at address `x` has its lower 4 bits flipped
  * Byte at address `x+1` has its upper 4 bits flipped
  * Byte at address `x+2` has its middle 4 bits flipped
  * Byte at address `x+3` has its top 2 and lowest 2 bits flipped

Then prints `x` as a character string of 4 decoded bytes

Integers that should translate correctly:
* 3108409701
* 3109389662
* 2824443240
* 2790760293
* 2722795845
* 2823722341
* 2890309485


`str_transition.asm`

Takes in a string, turns all lowercase ASCII to uppercase, turns all periods to exclamation marks

### Assembly Language - Fibonacci Sequence
Calculates a modified fibonacci number given a user-input index. Modified function `f(n) = f(n-1) + f(n-2) + f(n-3)`, with `f(1)=1, f(2)=1, f(3)=1`

`fib3_nonrecurs_full.asm`

Full (main) asm file for a nonrecursive solution

`fib3_recursive_function.asm`

Function with a global file, with a recursive solution


`changestr.asm`

Prompts the user for a string of characters, changes the string in place: lowercase letters become uppercase, periods become exclamation marks; prints changed string back to console


`4functions.asm`

Creates four functions as follows:

  1. Receives address of string as well as its length, changes the string's characters in place from lowercase letters to uppercase
  
  2. Receives three 32-bit integers and computes `4*(a + b) + 3*c`, returning the result in `eax`
  
  3. Receives address of array as well as its length, returns in `eax` the number of negative numbers in the array
  
  4. Receives three 32-bit integers and returns the smallest of the three in `eax`
