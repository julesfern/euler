#!/usr/bin/env ruby

# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing 
# over five-thousand first names, begin by sorting it into alphabetical order. Then working
# out the alphabetical value for each name, multiply this value by its alphabetical 
# position in the list to obtain a name score.
#
# For example, when the list is sorted into alphabetical order, COLIN, which is worth 
# 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score 
# of 938  53 = 49714.
#
# What is the total of all the name scores in the file?

# Thinking out loud:
# THIS IS NOT MATH

file_contents = File.open(File.join(File.dirname(__FILE__), "resource", "problem-22-names.txt")).read

letters = %w(_ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
names = file_contents.split(",").map {|str| str.gsub('"',"") }.sort

sum = 0
names.each_with_index do |name, index|

	# Calculate name score
  namescore = 0
  name.split("").each do |char|
    namescore += letters.index(char)
  end

  # Add list position
  namescore *= index+1

  # Increment
  sum += namescore

end

puts sum