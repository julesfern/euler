#!/usr/bin/env ruby

# The following iterative sequence is defined for the set of positive integers:
# 
# n -> n/2 (n is even)
# n -> 3n + 1 (n is odd)
# 
# Using the rule above and starting with 13, we generate the following sequence:
# 
# 13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
#
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. 
# Although it has not been proved yet (Collatz Problem), it is thought that all starting 
# numbers finish at 1.
# 
# Which starting number, under one million, produces the longest chain?
# 
# NOTE: Once the chain starts the terms are allowed to go above one million.

# Thinking out loud:
# Seems simple enough. I reckon we want to do this in reverse to try for the longest sequence,
# but that seems like a gut decision rather than one based in reason. Sod it, I'll run with it.
# Mercifully we don't need to store results, so this doesn't turn into one of those bastard
# array-allocation memory bandwidth problems. This should be almost entirely CPU-bound.
#
# The naive solution took 1m25s to run - not good enough. But I did find that the max sequence
# length was only 525, which is easily addressable.
#
# Let's actually make use of some of that RAM by caching sequence tails - any N found in the sequence 
# may then possibly retrieve the rest of the sequence from cache. This will involve counting up,
# not down, so we can actually build the cache.
#
# That reduced runtime by 1 minute - down to 24 seconds.
#
# Thinking about the sequence, it is clearly going to be longest for odd numbers. Let's try
# testing odds only. Another 4 seconds off by that route.
# 
# Next let's optimise memory access by caching tail lengths, not tails themselves.
# Halved the time again - 10 seconds, now. Ruby arrays really aren't too efficient.
#
# Perhaps I can increase the number of cache hits, but I'll likely move on and come back to this
# one.

max = 1_000_000
start = 500_001 # Sensible starting point
n = start
r,c = 0,0 # Result, count
cache = [] # Using index 'n' to store sequence tails from starting point 'n'

until n >= max do
	#puts "running for #{n}"

	# Take n and generate the sequence
	sm,sl = n,1 # sequence member, sequence length (including initial n value)

	until sm == 1 do
		sm = (sm%2==0)? sm/2 : (3*sm)+1

		if cv = cache[sm]
		 sl += cv
		 break
		else
		 sl+=1
		end
	end
	cache[n] = sl # Cache the sequence

	r,c = n,sl if sl > c

	n+=2
end

puts "Longest chain was #{c} from starting number #{r}"