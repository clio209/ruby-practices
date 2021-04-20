#!/usr/bin/env ruby
require 'date'
require 'optparse'
today = Date.today

options = ARGV.getopts('m:','y:')

target_year = options["y"].to_i
target_month = options["m"].to_i

if target_year == 0
   target_year = today.year
end

if target_month == 0
   target_month = today.month
end

targetday = Date.new(target_year, target_month,1)
targetday_wday = Date.new(target_year, target_month,1).wday
targetday_lastday =Date.new(target_year, target_month,-1).day
head = targetday.strftime('%-m月 %Y').center(20)
weekdays = ["日", "月", "火", "水", "木", "金", "土"]

puts head
puts weekdays.join(" ")
print "   " * targetday_wday

(1..targetday_lastday).each do |date|
print date.to_s.rjust(2) + " "

targetday_wday = targetday_wday + 1
if targetday_wday%7 == 0
   print "\n"
end
end

if targetday_wday%7!=0
   print "\n"
end

