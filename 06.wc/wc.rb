#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
# lが入力されていた場合、true 返す
option = ARGV.getopts('l')
# ファイルそれぞれの情報を出力する
line_total = 0
count_total = 0
size_total = 0
ARGV.each do |file|
  line = File.read(file).count("\n")
  count = File.read(file).split(/\s+/).count
  size = File.read(file).bytesize
  file_length = file.size

  line_total += line
  count_total += count
  size_total += size

  if option['l']
    print "#{line.to_s.rjust(8)}#{file.rjust(file_length + 1)}\n"
  else
    print "#{line.to_s.rjust(8)}#{count.to_s.rjust(8)}#{size.to_s.rjust(8)}#{file.rjust(file_length + 1)}\n"
  end
end

# 複数ファイルの場合はtotal行の出力を行う処理
if ARGV.size >= 2
  if option['l']
    print "#{line_total.to_s.rjust(8)}#{'total'.to_s.rjust(6)}\n"
  else
    print "#{line_total.to_s.rjust(8)}#{count_total.to_s.rjust(8)}#{size_total.to_s.rjust(8)}#{'total'.to_s.rjust(6)}\n"
  end
end

# コマンドに入力がない場合の出力処理
if ARGV == []
  input_data = $stdin.read
  line = input_data.count("\n")
  count = input_data.split(/\s+/).count
  size = input_data.bytesize
  print "#{line.to_s.rjust(8)}#{count.to_s.rjust(8)}#{size.to_s.rjust(8)}\n"
end
