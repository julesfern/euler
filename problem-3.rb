#!/usr/bin/env ruby

# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143 ?

def prime?(n)
	# This is a naive prime check but is fast enough for the size of number we're using
	(2..(n**0.5)).each {|i| return false if n%i==0 }
	true
end

def lpf(n)
	f = (n**0.5).to_i; f = (f%2==0)? f-1 : f;
	while(f>=2) do; return f if n%f==0 and prime?(f); f-=2; end
end

puts "Example"
puts lpf(13195)

puts "Question"
puts lpf(600851475143)5