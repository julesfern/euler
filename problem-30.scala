#!/bin/sh
exec scala -deprecation "$0" "$@"
!#

/*
  Surprisingly there are only three numbers that can be 
  written as the sum of fourth powers of their digits:

  1634 = 1^4 + 6^4 + 3^4 + 4^4
  8208 = 8^4 + 2^4 + 0^4 + 8^4
  9474 = 9^4 + 4^4 + 7^4 + 4^4

  As 1 = 1^4 is not a sum it is not included.

  The sum of these numbers is 1634 + 8208 + 9474 = 19316.

  Find the sum of all the numbers that can be written as the 
  sum of fifth powers of their digits.
*/

/*
  Thinking out loud:

  This sounds like it is best achieved with combinatorics than it
  is by iterating from 0 to infinity.

  Unless we don't have to iterate to infinity. A little buggering
  around with multiples of 9^5 (the max for any digit) gives us an
  upper limit of 354,294 (a six digit number, therefore naturally
  out of bounds for the purposes of the question)
*/

import scala.math

val nums = Range(2, 354295)
var sum: Int = 0

nums.foreach(n => {
  val ns = "%d".format(n)
  var tot = 0

  ns.foreach(c => {
    tot += math.pow("%s".format(c).toInt, 5).intValue
  })

  if(tot == n) sum += n
})

println(sum)