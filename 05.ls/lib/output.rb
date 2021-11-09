# frozen_string_literal: true

require_relative './filename'
require_relative './command'

class Output
  attr_reader :command

  COLUMN = 3

  def initialize
    @filename = FileName.new
  end

  def output_normal
    transposed_array = @filename.transposed_array
    transposed_array.each do |names|
      names.each do |name|
        print name.to_s.ljust(30)
      end
      print "\n"
    end
  end

  def output_l
    total = @filename.total_blocks
    puts "total #{total}"
    @ls_files = @filename.ls_files
    l_list = @ls_files.map(&:l_line)
    l_list.each { |data| puts data }
  end

  def output
    if @filename.command.command_l?
      output_l
    else
      output_normal
    end
  end
end
