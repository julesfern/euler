#!/bin/sh
exec scala -deprecation "$0" "$@"
!#

/*
  Euler published the remarkable quadratic formula:

  n² + n + 41

  It turns out that the formula will produce 40 primes for 
  the consecutive values n = 0 to 39. However, when 

  n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, 
  and certainly when n = 41, 41² + 41 + 41 is clearly 
  divisible by 41.

  Using computers, the incredible formula  n² - 79n + 1601 was 
  discovered, which produces 80 primes for the consecutive values 
  n = 0 to 79. The product of the coefficients, 79 and 1601, is 
  126479.

  Considering quadratics of the form:

  n² + an + b, where |a| < 1000 and |b| < 1000

  where |n| is the modulus/absolute value of n
  e.g. |11| = 11 and |4| = 4

  Find the product of the coefficients, a and b, for the quadratic 
  expression that produces the maximum number of primes for 
  consecutive values of n, starting with n = 0.
*/

/*
  Thinking out loud - so there's no upper limit on n, but we can
  stop computing a permutation as soon as it fails to yield a prime.

  I have a hunch that the clue lies in the easily extricable limits
  for Euler's equation, which is conspicuous by its inclusion in 
  the question.

  The function:

  f(n) = n² + an + b 

  fails by definition to yield a prime if n, a and b 
  are all equal to x: (x*x + x*x + x) % x == 0.

  Clearly, the question doesn't intend for us to iterate
  each of the possible combinations of a and b. Instead,
  we'll be expected to probe the implicit limits of the
  function to reduce the load expected of us.

  Follow:
  f(n) must generate a sequence of primes for n>=0
  f(0) = 0 + 0*a + b
  f(0) = b
  f(0) must be prime
  Therefore b must always be prime and |b| < 1000.

  And:
  With small values of |b|, only small sequences of
  primes can be generated due to the quadratic scaling
  of n over iterations. I suspect that I should check
  values of b in reverse order.

  Furthermore:
  Nobody ever guaranteed that the primes arrive in any
  sort of order. Given the distribution of prime
  numbers across the general range of integers, if |b|
  has a high value then I can assume with relatively good
  confidence that we're actually descending through
  the primes with a negative value of a that is quite
  large in terms of |a|.

  Finally:
  Prime numbers (barring 2) are necessarily odd.
  Given n² + an + b = n(a+n) + b
  if a is even, then n(a+n) will flipflop between odd
  and even values for values of n, causing n(a+n)+b to
  flipflop between odd and even values and thus generate
  crap prime sequences. Let's only test odd values of a.

  So far:
  only check prime values of b
  only check values of b < a
  only check values of a < 0 (guesswork, but I'm pretty confident)

  Let's give it a shot with those constraints.  
*/

import scala.math

// Bring in the prime checker
def ints(n: Int): Stream[Int] = n #:: ints(n+1)
def primes(nums: Stream[Int]): Stream[Int] =
  nums.head #:: primes (nums.tail.filter(x => x % nums.head != 0))
def is_prime(n: Int): Boolean =
  n == 1 || (n>=2 && primes(ints(2)).takeWhile(p => (p <= n)).last == n)
  

val n_vals = ints(0) // Stream of all integer values for n
val a_vals = -999 to 0 by 2 // Guesswork, see above
// Similar guesswork for values of b.
val b_vals = primes(ints(2)).takeWhile(p => p < 1000).filter(p => p > 500).toList.reverse

var n_max = 0
var ab_max = 0

// f(n) = n² + an + b 
def f(n: Int, a: Int, b: Int): Int = math.pow(n, 2).intValue + a*n + b

a_vals.foreach(a => {
  b_vals.foreach(b => {
      val f_primes = n_vals.takeWhile(n => {
        is_prime(f(n, a, b))
      })
      if(f_primes.last > n_max) {
        n_max = f_primes.last
        ab_max = a*b
      }
    })
})

println("Greatest ab coefficient %d for %d consecutive primes".format(ab_max, n_max))
