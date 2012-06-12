#!/usr/bin/env ruby

# Starting in the top left corner of a 2x2 grid, there are 6 routes (without backtracking) to the bottom right corner.
# How many routes are there through a 20x20 grid?
# (Note, this includes the outer edges)

# Thinking out loud: awesome, a pathfinding problem. I wonder if this is going to come up again
# later, but with obstructions to confound the algorithm.
# 
# I can either plot all the routes by brute force, or look for a combinatorial solution that 
# takes in the grid dimensions.
#
# The no-backtracking rule confounds the calculations a little. Starting top left, i'm going to make
# N decisions each with two outcomes - right, or down. I have to make {width} right decisions and {height}
# down decisions, but I can make them in any order.
#
# Thus we are searching for the number of permutations for 20 rights and 20 downs.
# 
# Let us think of a path as a permutation of 40 unique moves - d1,d2,d3...d20, r1,r2,r3...r20.
# You must execute each move but you may execute them in any order.
#
# Of course, that doesn't work, because d1, d2, d3 etc. must appear in strict but may be 
# interpolated with r1,r2,r3...r20 in order. And so this becomes a question of determining the number
# of possible interpolated configurations.
#
# Let's try a naive recursive version. Waaay too slow. We'll be wanting to cache the results
# of each coordinate to speed that up.
#
# Much better.
#
# Later note: After solving this I did some reading up to see what the formula was, and it turns
# out to be Pascal's Triangle. Interesting stuff.

@w,@h = 20,20 # Grid size (squares)
x,y = 0,0 # Current coords (intersections, not squares)

@cache = []; (@w+1).times { @cache << [] } # Cache has columns first, so access is by [x][y]

def pathfind(x,y)
	return @cache[x][y] || @cache[x][y] = if x < @w and y < @h
				# From any given junction the number of paths available is the sum of
				# The routes from the two intersections below and to the right.
				pathfind(x+1,y)+pathfind(x,y+1)
			else
				1 # At final destination or at either edge, you have 1 route available
			end
	
end

puts pathfind(x,y)