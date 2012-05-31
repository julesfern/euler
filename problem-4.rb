#!/usr/bin/env ruby

#A palindromic number reads the same both ways. 
#The largest palindrome made from the product of two 2-digit numbers is 9009 = 91*99.
#Find the largest palindrome made from the product of two 3-digit numbers.

min,max = 900,999
f = [max+1,max]; r = [0,max,max]

until f == [min,min] do
	f = (f[0]==min)? [max, f[1]-1] : [f[0]-1, f[1]]

	n = f[0]*f[1]
	r = [n]+f if n > r[0] and n.to_s == n.to_s.reverse
end

puts "#{r[0]}, product of #{r[1]} and #{r[2]}"