#!/bin/sh
exec scala -deprecation "$0" "$@"
!#

/*
  We shall say that an n-digit number is pandigital if it 
  makes use of all the digits 1 to n exactly once; for example, 
  the 5-digit number, 15234, is 1 through 5 pandigital.

  The product 7254 is unusual, as the identity, 39 x 186 = 7254, 
  containing multiplicand, multiplier, and product is 1 through 
  9 pandigital.

  Find the sum of all products whose multiplicand/multiplier/product
  identity can be written as a 1 through 9 pandigital.

  HINT: Some products can be obtained in more than one way so be sure
  to only include it once in your sum.
*/

/*
  Thinking out loud:

  Oh gods I hate sudoku. This isn't sudoku. But it's close enough
  that I don't like this either.

  Some obvious limits - the largest possible 4-character left-hand
  identies aren't large enough to be 1-9 pandigital:

  98 * 76 = 7448 (all similar 4-digit alternatives have 4-digit products)

  The smallest 5-digit left-hand identities:
  2*1345 = 2690 -> just right
  Largest 5-digit:
  9*8765 = 78885 -> too large

  Smallest 6-digit:
  2*13456 = 26912 -> too large

  I'm confident that a plotted curve of n(digits on left) : n(digits in product)
  has a safe area for us to target where the left-hand side has 5 digits.

  I have no formal proof of this.

  Also I need to filter out any products that were already found.  I don't need
  to do any cache-keying by the two factors because for any product there can be
  only two factors that produce that product while remaining pandigital.
*/

var sum = 0
val digits = List[Int](1, 2, 3, 4, 5, 6, 7, 8, 9)
val lhsize = 5
var products = List[Int]()

digits.permutations foreach(seq => {
  // Break into left and right side
  val (l, r) = seq.splitAt(lhsize)
  val p = r.mkString("").toInt

  // Iterate over combinations of left side
  for(i <- 1 to lhsize-1) {
    val (la, lb) = l.splitAt(i)
    val m1 = la.mkString("").toInt
    val m2 = lb.mkString("").toInt

    // If product matches, increment sum by product
    if(m1*m2 == p) {
      println("Found one: "+m1+" x "+m2.toString+" = "+p.toString)
      products = p :: products
    }
  }
  
})

println("Sum distinct: %d".format(products.distinct.sum))