#!/usr/bin/env node

// A perfect number is a number for which the sum of its proper divisors is exactly 
// equal to the number. For example, the sum of the proper divisors of 28 would be 
// 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
//
// A number n is called deficient if the sum of its proper divisors is less than n
// and it is called abundant if this sum exceeds n.
//
// As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number 
// that can be written as the sum of two abundant numbers is 24. By mathematical analysis, 
// it can be shown that all integers greater than 28123 can be written as the sum of two 
// abundant numbers. However, this upper limit cannot be reduced any further by analysis 
// even though it is known that the greatest number that cannot be expressed as the sum 
// of two abundant numbers is less than this limit.
//
// Find the sum of all the positive integers which cannot be written as the sum of 
// two abundant numbers.

// Thinking out loud: let's pull in the algorithm from problem 20 and implement an
// abundant number checker with it.
//
// I decided to do a few problems in Javascript for fun.
//
// My algorithm from #20 turns out to be wrong, although it did generate the correct
// answer in that problem. Have corrected it here.

function d(n) {
  var sum = 1,
      lim = Math.floor(Math.pow(n, 0.5));
  for(var i=2; i<=lim; i++) {
    if(n%i==0) { 
      sum += i;
      if(n/i != i) sum += n/i;
    }
  }
  return sum;
}

function abundant(n) {
  return (d(n) > n);
}

var theoretical_max = 28123,
    smallest_abundant = 12,
    abundant_numbers = [],
    sum = 0,
    sieve = new Array(theoretical_max+1); // fixed length

// Prepopulate abundants array
for(var a=smallest_abundant; a<=theoretical_max; a++) {
  if(abundant(a)) abundant_numbers.push(a);
}

// Populate the flags list.
// The flags list is going to contain a boolean at an index corresponding
// to each 'n' - true if 'n' is the sum of two abundant numbers, undefined 
// if not.
//
// This is very similar in behaviour to a sieving algorithm.

for(var i=0; i<abundant_numbers.length; i++) {
  var ai = abundant_numbers[i];
  marker: for(var j=i; j<abundant_numbers.length; j++) {
    var aj = abundant_numbers[j],
        as = aj+ai;
    if(as > theoretical_max) break marker;
    sieve[as] = true;
  }
}

for(var s=1; s<=theoretical_max; s++) {
  if(sieve[s] != true) sum += s;
}

console.log(sum);