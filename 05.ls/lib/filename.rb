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
                      else
                        Dir.glob('*').sort
                      end
    @array_filename = @array_filename.reverse if @command.command_r?
  end

  def ls_files
    @array_filename.map { |filename| LsFile.new(filename) }
  end

  def transposed_array
    array_data = @array_filename
    array_data << nil until (array_data.size % COLUMN).zero?
    sliced_array = array_data.each_slice(array_data.size / COLUMN).to_a
    transposed_array = sliced_array.transpose
  end

  def total_blocks
    total = @array_filename.sum { |arr| File.stat(arr).blocks }
  end
end
