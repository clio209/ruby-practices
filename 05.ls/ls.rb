#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('a', 'l', 'r')

array = []

if options['l'] == true

  Dir.glob('*').sort.each do |item|
    array << item
  end

  def file_type(type)
    { 'file' => '-', 'directory' => 'd', 'link' => 'l' }[type]
  end

  def permission(number)
    { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }[number]
  end

  def mode_permission(mode_input)
    permission_info = []
    mode_input.each do |mode|
      permission_info << permission(mode)
    end
    permission_info = permission_info.join
  end

  total = array.sum { |arr| File.stat(arr).blocks }
  puts "total #{total}"

  array.each do |d|
    data = File.stat(d)
    mode_f = mode_permission(data.mode.to_s(8).slice(/\d{3}$/).split(//))
    uid_f = Etc.getpwuid(data.uid).name
    gid_f = Etc.getgrgid(data.gid).name
    time_f = data.mtime.strftime('%m %d %R')
    print "#{file_type(data.ftype)}#{mode_f} #{data.nlink.to_s.rjust(4)} #{uid_f}  #{gid_f}  #{data.size.to_s.rjust(5)} #{time_f} #{d}\n"
  end
end

if options['a'] == true
  Dir.glob('*', File::FNM_DOTMATCH).sort.each do |item|
    array << item
  end

  array << nil until (array.size % 3).zero?
  sliced_array = array.each_slice(array.size / 3).to_a
  transposed_array = sliced_array.transpose
  transposed_array.each do |names|
    names.each do |name|
      print name.to_s.ljust(30)
    end
    print "\n"
  end
end

if options['r'] == true
  Dir.glob('*').sort.reverse_each do |item|
    array << item
  end

  array << nil until (array.size % 3).zero?
  sliced_array = array.each_slice(array.size / 3).to_a
  transposed_array = sliced_array.transpose
  transposed_array.each do |names|
    names.each do |name|
      print name.to_s.ljust(30)
    end
    print "\n"
  end
end

unless options['r'] == true || options['a'] == true || options['l'] == true
  Dir.glob('*').sort.each do |item|
    array << item
  end

  array << nil until (array.size % 3).zero?
  sliced_array = array.each_slice(array.size / 3).to_a
  transposed_array = sliced_array.transpose
  transposed_array.each do |names|
    names.each do |name|
      print name.to_s.ljust(30)
    end
    print "\n"
  end
end
