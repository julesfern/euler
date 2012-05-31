#!/usr/bin/env ruby

# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
# ----------------------------------------------------

# Thinking out loud:
# We're going to test a number (n) for a set of contiguous factors.
# I started with a naive implementation which generated the right answer, slowly.
# It repeatedly incremented n by the highest factor given by the problem (20).
# 
# An improved version skips through the range of contiguous factors, and searches
# for (n) to match slices of the range. When an (n) is found, we know that
# (n) for the next expansion of the range must itself be a factor of (n),
# and as such may use (n) as the new loop increment.
#
# For instance, contiguous factors 1..3 have a solution, 6. To solve for 1..4,
# we know that the (n) must be a factor of 6, such that it remains divisible by
# 1,2 and 3, and also a factor of 4 - the rest of the range may be excluded. 
# As such, we may increment our test candidate by the previous solution, and
# test that it is also a factor of the next number in the contiguous range.
#
# This resembles a checksumming problem I once overheard in an interview.

f = 3 # factoring starts at 3 - 1 and 2 are meaningless values to test given the way we'll be loop stepping
n = 2 # Our current candidate solution
inc = 2 # The current loop step. This will increase as we find more factors.

while f<=20 do # Put a cap of 20 on the solver
	if n%f == 0
		puts "#{n} divisible by 1..#{f}"
		inc=n # Start stepping by the found solution
		f+=1 # Now solve for the next factor
	else
		n+=inc # Increment by the answer to the previous iteration
	end
end 