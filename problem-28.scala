#!/bin/sh
exec scala -deprecation "$0" "$@"
!#

/*
  Starting with the number 1 and moving to the right in a clockwise 
  direction a 5 by 5 spiral is formed as follows:

  21 22 23 24 25
  20  7  8  9 10
  19  6  1  2 11
  18  5  4  3 12
  17 16 15 14 13

  It can be verified that the sum of the numbers on the diagonals is 101.

  What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral 
  formed in the same way?
*/

/*
  Thinking out loud:

  I'd rather be "clever" with the way I access the sequence than
  generate a bloody spiral-access array.

  The sequence isn't so complicated. Scala's List class can easily
  handle it, and is well-suited to recursion of this sort.
*/

import scala.math

// Where 'size' is the width and height, which must be equal
// anyway so why make you supply two args?
def corners_of_spiral(size: Int): List[Int] = size match {
  case 0 | 1 =>
    List[Int](size)
  case s =>
    val max = math.pow(s, 2).intValue    
    List[Int](max, max-(s-1), max-2*(s-1), max-3*(s-1)) ::: corners_of_spiral(s-2)
}

println(corners_of_spiral(1001).sum)