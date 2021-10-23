# frozen_string_literal: true

require_relative './basedata'
require_relative './command'
require_relative './ldata'

class Output
  COLUMN = 3
  FILE_TYPE = { 'file' => '-', 'directory' => 'd', 'link' => 'l' }.freeze
  PERMISSION = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-',
                 '7' => 'rwx' }.freeze

  def initialize
    basedata = BaseData.new
    @base_data = basedata.make_data
    @command = basedata.command
  end

  def output_normal
    @base_data << nil until (@base_data.size % COLUMN).zero?
    sliced_array = @base_data.each_slice(@base_data.size / COLUMN).to_a
    transposed_array = sliced_array.transpose
    transposed_array.each do |names|
      names.each do |name|
        print name.to_s.ljust(30)
      end
      print "\n"
    end
  end

  def output_l
    ldata = Ldata.new(@base_data)
    @l_data = ldata.make_data_l
    total = @base_data.sum { |arr| File.stat(arr).blocks }
    puts "total #{total}"
    @l_data.each { |data| puts data }
  end

  def output
    if @command.command_l?
      output_l
    else
      output_normal
    end
  end
end
