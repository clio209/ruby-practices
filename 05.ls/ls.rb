#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

FILE_TYPE = { 'file' => '-', 'directory' => 'd', 'link' => 'l' }.freeze

PERMISSION = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }.freeze

COLUMN = 3

# permissionのアルファベット列を出力する処理
def mode_permission(mode_input)
  permission_info = []
  mode_input.each do |mode|
    permission_info << PERMISSION[mode]
  end
  permission_info.join
end

# 3列にする処理
def adjust_column(array)
  array << nil until (array.size % COLUMN).zero?
  sliced_array = array.each_slice(array.size / COLUMN).to_a
  transposed_array = sliced_array.transpose
  transposed_array.each do |names|
    names.each do |name|
      print name.to_s.ljust(30)
    end
    print "\n"
  end
end

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

if options['l']
  total = array.sum { |arr| File.stat(arr).blocks }
  puts "total #{total}"

  array.each do |filename|
    data = File.stat(filename)
    mode = mode_permission(data.mode.to_s(8).slice(/\d{3}$/).split(//))
    owner = data.nlink.to_s.rjust(4)
    file_size = data.size.to_s.rjust(5)
    last_updated = data.mtime.strftime('%m %d %R')
    print "#{FILE_TYPE[data.ftype]}#{mode} #{owner} #{Etc.getpwuid(data.uid).name}  #{Etc.getgrgid(data.gid).name}  #{file_size} #{last_updated} #{filename}\n"
  end
else adjust_column(array)
end
