#!/usr/bin/env ruby

# The number, 197, is called a circular prime because all rotations of the 
# digits: 197, 971, and 719, are themselves prime.
# 
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 
# 71, 73, 79, and 97.
# 
# How many circular primes are there below one million?

# Thinking out loud:
# Fancied a little more Ruby.

def primes_upto(lim)
  primes = [2]
  sieve = [0,1]*(lim/2)
  n = 3
  while n<lim do
    if sieve[n] == 1
      # Check
      j = n**2 # Only need to start checking at the square of your current candidate. This knocks about 0.5s off the runtime.
      while j<lim do
        sieve[j] = 0
        j+=n
      end
      # Append
      primes << n
    end
    n+=2 # Don't check even numbers, silly
  end
  return primes
end

def rotate(s)
  s.gsub(/(\d)(\d+)/, '\2\1')
end

candidates = primes_upto(1_000_000)
circular_primes_count = 0

candidates.each do |n|
  catch :fail do
    c = n.to_s
    # Early exit for rotations with known composite endings 
    # (even number, or divisible by 5 or 10)
    throw :fail if c.length > 1 and c.match(/[246805]/)
    # Rotations, not permutations - rotate digits.length-1 times to avoid repeating
    r = c
    found = (1..(c.length-1)).each do |it|
      r = rotate(r)
      throw :fail unless candidates.include?(r.to_i)
    end
    circular_primes_count += 1
  end  
end

puts "Circular primes: #{circular_primes_count}"