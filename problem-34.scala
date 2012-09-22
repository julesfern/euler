#!/bin/sh
exec scala -deprecation "$0" "$@"
!#

/*
  145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

  Find the sum of all numbers which are equal to the sum of the 
  factorial of their digits.

  Note: as 1! = 1 and 2! = 2 are not sums they are not included.
*/

/*
  Thinking out loud:

  Interesting. There's a digit length limit here somewhere...

  9! = 362880
  8! =  40320
  7! =   5040
  6! =    720
  5! =    120
  4! =     24
  3! =      6
  2! =      2
  1! =      1

  My gut says the limit is going to be comparatively rather low,
  and will mostly involve mid-sized factorials. Probably no 9's
  as they're so damned expensive.
*/

def fact(n:Int):Int = if(n==1||n==0) 1 else n*fact(n-1)

val theoretical_lim = 3*fact(9) // total stab in the dark
var sum = 0

(3 to theoretical_lim).foreach(n => {
  val digits = n.toString.toList.map(x => (""+x).toInt)
  if(n == digits.map(fact(_)).sum) sum += n
})

println(sum)