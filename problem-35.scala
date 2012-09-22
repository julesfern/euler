#!/bin/sh
exec scala -deprecation "$0" "$@"
!#

/*
  The number, 197, is called a circular prime because all 
  rotations of the digits: 197, 971, and 719, are themselves 
  prime.

  There are thirteen such primes below 100: 
  2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

  How many circular primes are there below one million?
*/

/*
  Thinking out loud:

  Already have a lovely scala prime sieve. Time to bring
  that one out of retirement.
*/

def ints(n: Int): Stream[Int] = n #:: ints(n+1)
def primes(nums: Stream[Int]): Stream[Int] =
  nums.head #:: primes (nums.tail.filter(x => x % nums.head != 0))

val prime_candidates = primes(ints(2)).takeWhile( p => p < 1000000 )
var count = 0

prime_candidates.foreach(p => {
  println(p)
  // Determine if circular
  
})

println(count)