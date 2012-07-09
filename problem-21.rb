#!/usr/bin/env ruby

# Let d(n) be defined as the sum of proper divisors of n 
# (numbers less than n which divide evenly into n).
# 
# If d(a) = b and d(b) = a, where a != b, then a and b are an 
# amicable pair and each of a and b are called amicable numbers.
# 
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 
# 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper 
# divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
# 
# Evaluate the sum of all the amicable numbers under 10000.

# Thinking out loud: Okay. Prime factorisation with a twist. If I'm not careful
# this could be O(N^2) and that would be bad.
#
# We'll have to find the proper divisors of each number and store d(n)
# for later comparison, I guess.
#
# Actually, the numbers aren't high enough to bother with prime factorisation,
# since we only need to check factors up to n^-2 for numbers up to 10000.
#
# The prime factorisation method took approx. 10 seconds to run (and did generate
# the correct answer) - let's see if a simpler factor-finding algorithm does better.
#
# Super-naive version went up to 16 seconds. So let's look at a faster factorisation.


def d(n)
  sum = 1
  lim = n**0.5
  (2..(lim.ceil)).each do |i|
    sum += i + (n/i) if n%i==0
  end
  return sum
end

# Params
max = 10000 # Limit posited by question
amicables = []

(2..(max-1)).each do |i|
  #If d(i) = b and d(b) = ni, where i != b
  b = d(i)
  amicables += [b,i] if i!=b and i==d(b)
end

puts d(284)
puts "Sum of amicable numbers under #{max}: #{amicables.uniq.inject(:+)}"