#!/usr/bin/env ruby


# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, 
# we can see that the 6th prime is 13.
#
# What is the 10 001st prime number?

i=6; n=13;

# Yes, I know Ruby 1.9 has a prime generator. Using it would seem to be
# against the spirit of the thing.
#
# Also a list of prior primes could be used, and the prime candidate checked
# for divisibility against those members of the prime list < candidate^-2,
# but for numbers in the range we're looking at, it is faster to do it this
# way due to array performance. Better to keep it on the CPU as much as poss.
def prime?(n)
	# This is a naive prime check but is fast enough for the size of number 
	# we're using
	(3..(n**0.5)).each {|i| return false if n%i==0 }
	true
end

while i<10001 do
	n+=2
	i+=1 if prime?(n)
end

puts [i,n].inspect