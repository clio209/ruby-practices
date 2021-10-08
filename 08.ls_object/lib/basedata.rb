# frozen_string_literal: true

require 'optparse'
require 'etc'
require_relative './command'

class BaseData
  attr_reader :command, :command_a, :command_l, :command_r

  def initialize
    @command = Command.make_command
  end

  def make_data
    base_data = if @command.command_a
                  Dir.glob('*', File::FNM_DOTMATCH).sort
                else
                  Dir.glob('*').sort
                end
    base_data = base_data.reverse if @command.command_r
    base_data
  end
end
