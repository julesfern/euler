#!/usr/bin/env ruby

# A Pythagorean triplet is a set of three natural numbers, a  b  c, for which,
#
# a^2 + b^2 = c^2
# For example, 32 + 42 = 9 + 16 = 25 = 52.
#
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.
# -------------------------------------

# -------------------------------------
# Thinking out loud:
# We could brute force it like this, which runs in about 8 seconds on my linux VM:

# sum = 1000
# l = sum/2
# 
# for a in 1..l do
# 	for b in a..l do
# 		for c in b..l do
# 			puts "#{a}+#{b}+#{c}=#{sum}; {a}*#{b}*#{c}==#{a*b*c}" if a+b+c==sum and a**2+b**2==c**2
# 		end
# 	end
# end

# But for something faster; this looks suspiciously like simultaneous equations:
# 1: a^2 + b^2 = c^2
# 2: a+b+c = 1000
# 3: x = abc
#
# However there are 4 unknowns and only 3 data points. 
#
# Perhaps that is enough. There are enough data points to destructure the problem
# and brute-force the last component, which will surely be faster than brute-forcing 
# all 3 to find x.
#
# Let's bugger around with rearrangement and substitution.
#
# 1: a^2 + b^2 = c^2
# 2: a + b + c = 1000
# 	=> c = 1000 - (a+b) 
# 	=> c = 1000 - a - b
# 1: a^2 + b^2 = (1000-a-b))^2
# 	=> 	a^2 + b^2 	= 1000(1000-a-b) - a(1000-a-b) - b(1000-a-b)
#  	=> 				= ... (thanks for saving me some work there, wolfram alpha)
# 	=> 				= 1000000 - 2000a - 2000b + 2ab + (a^2 + b^2)
# 	Reverse for legibility, subtract a^2+b^2 from both sides:
# 	=> 1000000 - 2000a - 2000b + 2ab = 0
# 	=> 2000a + 2000b - 2ab = 1000000
# 	=> 1000a + 1000b - ab = 500000
# 	=> a(1000-b) + 1000b = 500000
# 	=> a(1000-b) = 500000 - 1000b
# 	=> a = (500000-1000b) / (1000-b)

for b in 1..1000 do
	a = (500000.0-(1000*b))/(1000-b) # Coerce float. Curse you, Ruby.
	if a%1==0
		a = a.to_i # Clean output
		c = 1000-(a+b)
		puts "#{a}+#{b}+#{c}=#{a+b+c}; #{a}*#{b}*#{c}==#{a*b*c}"
		break
	end
end

# This now runs in 0.005 seconds on the same VM. Much better.