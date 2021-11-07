# frozen_string_literal: true

require_relative './filename'
require_relative './command'

class Output
  attr_reader :command

  COLUMN = 3
  FILE_TYPE = { 'file' => '-', 'directory' => 'd', 'link' => 'l' }.freeze
  PERMISSION = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-',
                 '7' => 'rwx' }.freeze

  def initialize
    @filename = FileName.new
  end

  def output_normal
    @filename.transposed_array
  end

  def output_l
    @filename.output_total
    @ls_files = @filename.make_lsfile
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
