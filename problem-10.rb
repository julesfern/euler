#!/usr/bin/env ruby

# Question:
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
# Find the sum of all the primes below two million.
# -------------------------------------------------

# -------------------------------------------------
# Thinking out loud:
# Another prime generation problem. I wonder if the prime table I didn't use
# in problem 7 (due to memory bottlenecks) will find its way into the mix here;
# the performance impact may be outweighed by the size of primes we're searching for.
#
# Again, I refuse to use the in-built Ruby 1.9 prime generator as I'm trying to 
# bloody learn something here.
#
# With the naive implementation, runtime is approx 2.5 minutes:
#
def prime_naive?(n)
	(2..(n**0.5)).each {|i| return false if n%i==0 }
 	true
end
# lim = 2000000
# sum = 2 # skipping first iteration
# n = 3
# a = []
# until n>lim do
#   sum+=n and a<<n if prime_naive?(n)
#   n+=2
# end
# puts "Sum up to #{lim}: #{sum}"
#
# The prime table approach was abhorrently slow due to memory bottlenecks
# in ruby, so let's try sieving an array of candidates using the
# Sieve of Eratosthenes (http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes).

lim = 2000000

# 0 for skip, 1 for check. Start out with the even numbers marked.
# The closest thing to a bitarray that ruby will give us. Treating it as
# a bit mask allows us to avoid allocating too many 'unsigned long' types.
sieve = [0,1]*(lim/2) 
n=3
sum = 2

while n<lim do
  if sieve[n] == 1
    # Check
    i = n**2 # Only need to start checking at the square of your current candidate. This knocks about 0.5s off the runtime.
    while i<lim do
      sieve[i] = 0
      i+=n
    end
    # Increment
    sum +=n
  end
  n+=2 # Don't check even numbers, silly
end

puts "sum primes up to #{lim} == #{sum}"