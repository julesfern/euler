#!/usr/bin/env node

/*

  The Fibonacci sequence is defined by the recurrence relation:

  F(n) = F(n-1) + F(n-2), where F(1) = 1 and F(2) = 1.
  Hence the first 12 terms will be:

  F(1)= 1
  F(2)= 1
  F(3)= 2
  F(4)= 3
  F(5)= 5
  F(6)= 8
  F(7)= 13
  F(8)= 21
  F(9)= 34
  F(10) = 55
  F(11) = 89
  F(12) = 144
  The 12th term, F(12), is the first term to contain three digits.

  What is the first term in the Fibonacci sequence to contain 1000 digits?

*/ 

/*
  Start with a naive version. Possibly move to a binary search if it's
  too slow.

  It's too slow. I'll have to run up in high steps to establish an upper
  limit to the range and start binary searching within that range.

  Also I've got major, major problems with stack depth. Memoization to
  the rescue.

  Oh, for fuck's sake. Lack of BigInt support in Javascript.

  I'VE HAD IT WITH THE LOT OF YOU
  I'M GOING TO DO THIS WITH SCALA
  I HOPE YOU'RE HAPPY
*/

var fib_cache = {};
function fib(n) {
  var k = n.toString();
  return fib_cache[k] || (fib_cache[k] = ((n==1||n==2)? 1 : fib(n-1)+fib(n-2)));
}
function fibStr(n) {
  return fib(n).toString();
}