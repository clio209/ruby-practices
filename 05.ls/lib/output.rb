# frozen_string_literal: true

require_relative './filename'
require_relative './command'
require_relative './ldata'

class Output
  COLUMN = 3
  FILE_TYPE = { 'file' => '-', 'directory' => 'd', 'link' => 'l' }.freeze
  PERMISSION = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-',
                 '7' => 'rwx' }.freeze

  def initialize
    @filename = FileName.new
    @array_filename = @filename.make_array
    @command = @filename.command
  end

  def output_normal
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

  def output_l
    @filename.make_total
    ldata = Ldata.new(@array_filename)
    ldata.make_data_l.each { |data| puts data }
  end

  def output
    if @command.command_l?
      output_l
    else
      output_normal
    end
  end
end
