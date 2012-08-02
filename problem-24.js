#!/usr/bin/env node

/*
  A permutation is an ordered arrangement of objects. 
  For example, 3124 is one possible permutation of the 
  digits 1, 2, 3 and 4. If all of the permutations are 
  listed numerically or alphabetically, we call it 
  lexicographic order. The lexicographic permutations 
  of 0, 1 and 2 are:

  012
  021
  102
  120
  201
  210

  What is the millionth lexicographic permutation of the 
  digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
*/

/*
  Thinking out loud:

  No way in hell I'm allocating a million arrays in memory.
  We'll work destructively on a single array instance and 
  iterate it 1000000 times.

  Sequence is going to look like:
  0123456789
  0123456798
  0123456879
  0123456897
  0123456978
  0123456987
  0123457689
  0123457698
  0123457869
  0123457896
  0123457968
  0123457986
  etc., iterating towards a reverse sort.

  Except probably not. I get the feeling that there's some
  insight I'm supposed to research to avoid brute force.

  Combinatorics tells me that the entire sequence:

  0123456789

  Has 10! permutations == 3,628,800. 
  Meanwhile 9! == 362880, providing not enough possibilities
  to reach the 1,000,000th iteration. Therefore we know that
  the permutation is going to advance the first column some of the way


  In fact, this is a graph problem:

                              0 1 2 3 4 5 6 7 8 9
                             /|\
                            1 2 3 4 5 6 7 8 9
                             /|\
                            1 3 4 5 6 7 8 9
                           /|\
                          3 4 5 6 7 8 9
                               /|\
                              3 4 5 7 8 9

  Given the iteration number, we could predict which branches
  the permutation will take. We could partition the 10!
  permutation space for the initial digit in order to determine:

  For the first 9! permutations, the first digit will be 0.
  For the next 9! permutations, the first digit will be 1.
  For the final 9! permutations, between 9*9! and 10*9!(==10!), 
  the first digit will be 9.

  For the second row we could probably partition based on a 9-way
  split of the 8! probability space, and then an 8-way split of 7!,
  and so on down the rows until only a 1-way split of 0! remains.

  In fact, we can do this recursively. Once we've selected the first
  digit, we're calculating some iteration of the remaining digits.

  With 10! digits, and therefore 10! possibilities, we know that the
  first 0*9!..1*9! possibilities have a 0 at the start, the next
  1*9!..2*9! have 1, and 2*9!..3*9! start with 2. For the millionth
  iteration we can select 2 as the starting digit.

  To calculate the remaining digits, which have 9! possibilities, we
  can break up the range much the same way: 

  0*8!..1*8! -> 0
  1*8!..2*8! -> 1
  2*8!..3*8! -> 3 (2 is no longer available)

  The key is that when we select the first digit and move on to calculate
  the remainder of the sequence, we're no longer calculating the 1000000th
  permutation of the remaining sequence - we're actually calculating:

  1,000,000 - 2*9! -> iteration 274240 of the remaining 9-digit sequence

*/

var digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    target_permutation = 1000000;

function fact(n) {
  return (n <= 0)? 1 : n*fact(n-1);
}


function lexicographic_permutation(initial, permutation) {
  // Early exit for final iteration
  if(initial.length == 1) return initial;
  // Clone initial into an availability list
  var available = [];
  for(var ik in initial) available[ik] = initial[ik];
   
  // Establish calc variables  
  var n = available.length,
      next_permutation = permutation,
      p_size = fact(n-1), // space broken down into partition size for this permutation
      p = 0; // selected partition
  
  if(p_size < permutation) {
    p = Math.floor(permutation / p_size);
    if(permutation%p_size == 0) p-=1; // Fix for incorrectly-bounded array index
    next_permutation -= (p * p_size);
  }
    
  //console.log(available.length + " available. P "+permutation+" selects idx "+p+", need permutation "+next_permutation+" of remaining "+(available.length-1)+" digits");

  return available.splice(p,1)+lexicographic_permutation(available, next_permutation);
}

console.log("Permutation #"+target_permutation+": "+lexicographic_permutation(digits, target_permutation));