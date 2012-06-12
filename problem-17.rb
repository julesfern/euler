#!/usr/bin/env ruby

# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then 
# there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, 
# how many letters would be used?
#
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) 
# contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of 
# "and" when writing out numbers is in compliance with British usage.

# Thinking out loud: OH GODS EVEN PROJECT EULER WANTS ME TO WRITE RAILS HELPERS

@singles = %w(zero one two three four five six seven eight nine ten)
@tens = %w(zero ten twenty thirty forty fifty sixty seventy eighty ninety)
@teens = %w(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)

def say_number(actual)
	s = []
	n = actual
	until n == 0 do
		if n >= 1000
			thou = (n/1000).floor
			s << "#{@singles[thou]} thousand"
			n-=thou*1000
		elsif n >= 100
			hun = (n/100).floor
			s << "#{@singles[hun]} hundred"
			n-=hun*100
		elsif n >= 20
			ten = (n/10).floor
			ts = @tens[ten]
			n-= ten*10
			s << ((actual >= 100)? "and #{ts}" : ts)
		elsif n >= 10
			ts = @teens[n-10]
			s << ((actual >= 100)? "and #{ts}" : ts)
			n-=n
		elsif n > 0
			s << ((actual >= 100 and s.last and not s.last.match(/^and/))? "and #{@singles[n]}" : "#{@singles[n]}")
			n-=n
		end
	end
	return s.join(" ")
end

len = 0
(1..1000).each do |i|
	len += say_number(i).gsub(/(\s|-)/, "").length
end

puts len