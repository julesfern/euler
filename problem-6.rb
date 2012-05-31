#!/usr/bin/env ruby

# The sum of the squares of the first ten natural numbers is,
# 1^2 + 2^2 + ... + 10^2 = 385
#
# The square of the sum of the first ten natural numbers is,
# (1 + 2 + ... + 10)^2 = 552 = 3025
#
# Hence the difference between the sum of the squares of the first ten 
# natural numbers and the square of the sum is 3025 - 385 = 2640.
#
# Find the difference between the sum of the squares of the first one 
# hundred natural numbers and the square of the sum.

def sumsquare_upto(max)
	(1..max).inject {|sum, n| sum+=n**2 }
end

def squaresum_upto(max)
	(1..max).inject {|sum, n| sum+=n }**2
end

puts "Example"
puts squaresum_upto(10)-sumsquare_upto(10)

puts "Question"
puts squaresum_upto(100)-sumsquare_upto(100)