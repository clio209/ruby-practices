#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('a', 'l', 'r')

# arrayを各パターンに応じて確定させる
array = []
if options['a'] && options['r']
  Dir.glob('*', File::FNM_DOTMATCH).sort.reverse_each do |item|
    array << item
  end
elsif options['a']
  Dir.glob('*', File::FNM_DOTMATCH).sort.each do |item|
    array << item
  end
elsif options['r']
  Dir.glob('*').sort.reverse_each do |item|
    array << item
  end
else
  Dir.glob('*').sort.each do |item|
    array << item
  end
end

# permissionのアルファベット列を出力する処理
def mode_permission(mode_input)
  permission_info = []
  mode_input.each do |mode|
    permission_info << permission(mode)
  end
  permission_info = permission_info.join
end

if options['l']

  def file_type(type)
    { 'file' => '-', 'directory' => 'd', 'link' => 'l' }[type]
  end

  def permission(number)
    { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }[number]
  end

  total = array.sum { |arr| File.stat(arr).blocks }
  puts "total #{total}"

  array.each do |d|
    data = File.stat(d)
    mode = mode_permission(data.mode.to_s(8).slice(/\d{3}$/).split(//))
    owner = data.nlink.to_s.rjust(4)
    file_size = data.size.to_s.rjust(5)
    last_updated = data.mtime.strftime('%m %d %R')
    print "#{file_type(data.ftype)}#{mode} #{owner} #{Etc.getpwuid(data.uid).name}  #{Etc.getgrgid(data.gid).name}  #{file_size} #{last_updated} #{d}\n"
  end
end

# 3列にする処理
maltiple = 3
def adjust_maltiple(array, maltiple)
  array << nil until (array.size % maltiple).zero?
  sliced_array = array.each_slice(array.size / maltiple).to_a
  transposed_array = sliced_array.transpose
  transposed_array.each do |names|
    names.each do |name|
      print name.to_s.ljust(30)
    end
    print "\n"
  end
end

adjust_maltiple(array, maltiple) unless options['l']
