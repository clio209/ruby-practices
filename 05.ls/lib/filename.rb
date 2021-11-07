# frozen_string_literal: true

require 'optparse'
require 'etc'
require_relative './command'
require_relative './lsfile'
require_relative './output'

class FileName
  COLUMN = 3
  attr_reader :command

  def initialize
    @command = Command.make_command
    @array_filename = if @command.command_a?
                        Dir.glob('*', File::FNM_DOTMATCH).sort
                      elsif @command.command_r?
                        Dir.glob('*').sort.reverse
                      else
                        Dir.glob('*').sort
                      end
  end

  def make_lsfile
    @array_filename.map { |filename| LsFile.new(filename) }
  end

  def transposed_array
    @array_filename << nil until (@array_filename.size % COLUMN).zero?
    sliced_array = @array_filename.each_slice(@array_filename.size / COLUMN).to_a
    transposed_array = sliced_array.transpose
    transposed_array.each do |names|
      names.each do |name|
        print name.to_s.ljust(30)
      end
      print "\n"
    end
  end

  def output_total
    total = @array_filename.sum { |arr| File.stat(arr).blocks }
    puts "total #{total}"
  end
end
