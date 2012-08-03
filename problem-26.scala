#!/bin/sh
exec scala -deprecation "$0" "$@"
!#

/*
  A unit fraction contains 1 in the numerator. The decimal 
  representation of the unit fractions with denominators 
  2 to 10 are given:

  1/2 =   0.5
  1/3 =   0.(3)
  1/4 =   0.25
  1/5 =   0.2
  1/6 =   0.1(6)
  1/7 =   0.(142857)
  1/8 =   0.125
  1/9 =   0.(1)
  1/10  =   0.1
  
  Where 0.1(6) means 0.166666..., and has a 1-digit recurring 
  cycle. It can be seen that 1/7 has a 6-digit recurring cycle.

  Find the value of d < 1000 for which 1/d contains the longest 
  recurring cycle in its decimal fraction part.
*/

/* 
  Thinking out loud:

  Interesting problem. Pattern matching in scala is fun.
  I think this goes beyond Double or BigInt though - it 
  warrants some primary school math, in the form of long
  division.

  More interesting: http://en.wikipedia.org/wiki/Cyclic_number

  Most pertinent:

   > A cyclic number of length L is the digital representation 
   > of 1/(L + 1).
   >
   > Conversely, if the digital period of 1 /p (where p is prime) 
   > is p − 1, then the digits represent a cyclic number.
   >
   > For example:
   > 1/7 = 0.142857 142857….

  Evidently, we only need check each prime divisor P in order to 
  check for a repeating unit fraction of length P-1.

  Which means chunk-checking the resulting unit fraction is much
  easier, as we know what length of cycle to expect.

  Ah, yes - Wikipedia presents an algorithm which does indeed use
  long division to generate the unit fraction:

  > Cyclic numbers can be constructed by the following procedure:
  >
  > Let b be the number base (10 for decimal)
  > Let p be a prime that does not divide b.
  > Let t = 0.
  > Let r = 1.
  > Let n = 0.
  > loop:
  > Let t = t + 1
  > Let x = r · b
  > Let d = int(x / p)
  > Let r = x mod p
  > Let n = n · b + d
  > If r ≠ 1 then repeat the loop.
  > if t = p − 1 then n is a cyclic number.
  > 
  > This procedure works by computing the digits of 1 /p in base b, by 
  > long division. r is the remainder at each step, and d is the digit 
  > produced.
  >
  > The step: n = n · b + d
  >
  > serves simply to collect the digits. For computers not capable of 
  > expressing very large integers, the digits may be outputted or 
  > collected in another way.
  >
  > Note that if t ever exceeds p/ 2, then the number must be cyclic, 
  > without the need to compute the remaining digits.


*/

val max_divisor = 1000

// We need to find a list of primes up to our max_divisor
// I found this lovely sieve algorithm on literateprograms.org - 
// let's deconstruct it before moving on.

// This is a recursively-built stream of integers from 
// a starting number, n. It's a really beautiful example
// of lazy evaluation. See problem-25.scala for a similar
// example which builds the Fibonacci Sequence using Stream's
// built-in memoization and just-in-time value realisation.
def ints(n: Int): Stream[Int] = n #:: ints(n+1)

// Next we produce a stream of primes, using the same
// lazily-evaluated Stream logic. The stream takes the first
// item from 'nums' which is presumed to be prime, and filters
// the input stream to remove all of that item's multiples.
// The tail of the resulting stream (that is, the stream minus
// the first item) is then passed recursively to 'primes'
// so that the multiples of the next number may be filtered as well.
//
// I can only guess at the insane implementation code that goes into
// making Stream so beautiful.
def primes(nums: Stream[Int]): Stream[Int] =
  nums.head #:: primes (nums.tail.filter(x => x % nums.head != 0))

// Now we can begin the problem proper - taking our list of candidate
// divisors and preparing it for reverse iteration.
val divisors = primes(ints(2)).takeWhile( p => p < 1000 ).toList

// Translate the wikipedia algorithm into scala:
def unitFraction(p : Int, r : Int = 1, t : Int = 1) : List[Int] = {
  val x = r * 10 // where 10 == a fixed 'b' from the wikipedia algorithm
  val digit = (x / p).intValue
  val remain = x % p
  if(remain == 1) List(digit) else digit :: unitFraction(p, remain, t+1)
}

// I was using maxBy but then I realised that given the 
// length of the expected cycle is divisor-1, the longest
// cycle should therefore by the first cycle found, if
// we're going in reverse order.
val answer = divisors.reverse.find( 
  d => unitFraction(d).length == d-1 
)

println(answer.getOrElse("FAIL"))