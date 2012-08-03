#!/bin/sh
exec scala "$0" "$@"
!#

/*
  Alright, I knew this would happen. I'd end up using scala for these
  problems.

  Mercifully, Scala gives me some fairly sweet labour-saving features
  such as lazy evaluation of lists, which I'm now going to use for
  the Fibonacci sequence.
*/

import scala.math.BigInt

val targetLen:Int = 1000
val fibs: Stream[BigInt] = BigInt(0) #:: BigInt(1) #:: fibs.zip(fibs.tail).map { n => n._1 + n._2 }
val term = fibs.indexWhere(n => n.toString().length >= targetLen)

println("First term with %d digits: %d".format(targetLen, term))