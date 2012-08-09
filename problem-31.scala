#!/bin/sh
exec scala -deprecation "$0" "$@"
!#

/*
  In England the currency is made up of pound, £, and pence, p, 
  and there are eight coins in general circulation:

  1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
  It is possible to make £2 in the following way:

  1£1 + 150p + 220p + 15p + 12p + 31p
  How many different ways can £2 be made using any number of coins?
*/

/*
  Thinking out loud: 

  Combinatorics and recursion. Given a value, one can find out how
  many of a single coin it takes to make up that value. If there
  is a remainder, then the remainder can be made up of a combination
  of coins.

  The key is to work with denominations in descending order of size.
*/

val coins = List[Int](200, 100, 50, 20, 10, 5, 2, 1)

def coinCombo(value: Int, largestCoin: Int = coins.max): Int = {
  var combinations = 0
  coins.filter(x => x<=largestCoin).foreach(denom => {
    if(denom <= value) {
      if(value-denom > 0) combinations += coinCombo(value-denom, denom)
      else combinations +=1
    }
  })
  return combinations
}

println(coinCombo(200))