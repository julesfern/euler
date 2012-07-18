#!/usr/bin/env ruby

# A perfect number is a number for which the sum of its proper divisors is exactly 
# equal to the number. For example, the sum of the proper divisors of 28 would be 
# 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
#
# A number n is called deficient if the sum of its proper divisors is less than n
# and it is called abundant if this sum exceeds n.
#
# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number 
# that can be written as the sum of two abundant numbers is 24. By mathematical analysis, 
# it can be shown that all integers greater than 28123 can be written as the sum of two 
# abundant numbers. However, this upper limit cannot be reduced any further by analysis 
# even though it is known that the greatest number that cannot be expressed as the sum 
# of two abundant numbers is less than this limit.
#
# Find the sum of all the positive integers which cannot be written as the sum of 
# two abundant numbers.

# Thinking out loud: let's pull in the algorithm from problem 20 and implement an
# abundant number checker with it.

def d(n)
  sum = 1
  lim = n**0.5
  (2..(lim.ceil)).each do |i|
    sum += i + (n/i) if n%i==0
  end
  return sum
end

def abundant?(n)
	d(n) > n
end

theoretical_min = 12
theoretical_max = 28123
sum = 0

(theoretical_min..theoretical_max).each do |n|

  

end

puts sum