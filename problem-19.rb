#!/usr/bin/env ruby

# You are given the following information, but you may prefer to do some research for yourself.
# 
# 1 Jan 1900 was a Monday.
#
# Thirty days has September,
# April, June and November.
# All the rest have thirty-one,
# Saving February alone,
# Which has twenty-eight, rain or shine.
# And on leap years, twenty-nine.
#
# A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
#
# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?


# Thinking out loud: It's clear from the question that you're not really supposed to use a Date/DateTime library to 
# enumerate dates. I'll go with that and do something basic here.
#
# I've chosen to research the day of week for the start date in the range specified as this is permitted in the
# question text. 1 Jan 1901 was a Tuesday.
#
# I'll enumerate the days as Sunday, Monday ... Fri, Sat, such that any day falling on a day_index of 0 or a multiple
# of 7 is known to be a Sunday.

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
leap_days = days.dup; leap_days[1] = 29

count = 0
start_d = [1, 1, 1901]
current_d = start_d.dup
end_d = [31, 12, 2000]
day_index = 2 # Day index of start date

until current_d[2] > end_d[2] do

	# Iterate day
	day, mon, year = current_d
	use_days = (year%4==0 and (year%100!=0 or (year%100==0 and year%400==0)))? leap_days : days
	
	# Count
	count +=1 if (day_index == 0 or day_index%7==0) and day==1

	if day >= use_days[mon-1]
		day = 1
		if mon >= 12
			mon = 1
			year +=1
		else
			mon +=1
		end
	else
		day+=1
	end
	# Set current
	current_d = [day,mon,year]
	day_index +=1
	

end

puts "Count: #{count}"