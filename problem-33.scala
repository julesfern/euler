#!/bin/sh
exec scala -deprecation "$0" "$@"
!#

/*
  The fraction 49/98 is a curious fraction, as an inexperienced 
  mathematician in attempting to simplify it may incorrectly 
  believe that 49/98 = 4/8, which is correct, is obtained by 
  cancelling the 9s.

  We shall consider fractions like, 30/50 = 3/5, to be trivial 
  examples.

  There are exactly four non-trivial examples of this type of 
  fraction, less than one in value, and containing two digits 
  in the numerator and denominator.

  If the product of these four fractions is given in its lowest 
  common terms, find the value of the denominator.
*/

/*
  Thinking out loud:

  That... could be phrased more clearly. I think it means:

  1.  (49/98 == 4/8) evaluates to true
  2.  While applying the correct method to simplify this fraction
      will yield this answer, the correct answer may also be
      reached through by incorrect means - for instance, an
      inexperienced mathematician may attempt to cancel the
      9's even though 9 is not cancellable in this example. 
      Regardless, his inept number-pawing has yielded a correct
      result.
  3.  Find the other three examples of fractions like this, ignoring
      multiples of ten, and monkey about with their combined product.

  Obvious points:
  - The numerator and divisor will each contain two digits, 
    one of which is common to both
  - The numerator and divisor cannot both be divisible by this digit
  - Knocking out the common digit will return the same simplified fraction
    as actually simplifying the fraction.
*/

val f_vals = (11 to 100).toList.filter( x => x%10!=0 )
var n_prod = 1
var d_prod = 1

f_vals.foreach(d => {
  val ds = d.toString
  // Iterate over possible numerators < 1
  f_vals.filter(x => x<d).foreach(n => {
    val ns = n.toString
    // For each denominator, find common digit and check against criteria
    val i = ns.intersect(ds)
    if(i.length == 1) {
      val digit = i.toFloat
      if(!(d%digit==0 && n%digit==0)) {
        val correctly_simplified = n / d.toFloat
        
        val n_knockout = if(ns.startsWith(i)) ns.substring(1) else ns.substring(0,1)
        val d_knockout = if(ds.startsWith(i)) ds.substring(1) else ds.substring(0,1)
        val incorrectly_simplified = n_knockout.toFloat / d_knockout.toFloat

        if(correctly_simplified == incorrectly_simplified) {
          println("Found one such unseemly example: "+n+"/"+d)

          n_prod = n_prod*n
          d_prod = d_prod*d
        }
      }
    }    
  })
})

println("Fraction product (unsimplified): "+n_prod+"/"+d_prod)
// The answer is so easy to simplify by hand that I didn't bother writing an automated simplifier.