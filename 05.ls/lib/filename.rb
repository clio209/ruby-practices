# frozen_string_literal: true

require 'optparse'
require 'etc'
require_relative './command'

class FileName
  attr_reader :command

  def initialize
    @command = Command.make_command
  end

  def make_array
    @array_filename = if @command.command_a?
                   Dir.glob('*', File::FNM_DOTMATCH).sort
                 else
                   Dir.glob('*').sort
                 end
    @array_filename = @array_filename.reverse if @command.command_r?
    @array_filename
  end

  def make_total
    total = @array_filename.sum { |arr| File.stat(arr).blocks }
    puts "total #{total}"
  end
end
