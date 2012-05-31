#!/usr/bin/env ruby

# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
# Find the sum of all the multiples of 3 or 5 below 1000.

fizzbuzzer = Proc.new {|sum, n| sum += (n%3 == 0 or n%5 == 0)? n : 0 }

a,b = 0,10
puts "Example"
puts (a..(b-1)).inject &fizzbuzzer

puts "----"

c,d = 0,1000
puts "Question"
puts (c..(d-1)).inject &fizzbuzzer