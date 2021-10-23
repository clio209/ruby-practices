# frozen_string_literal: true

require 'optparse'

class Command
  attr_reader :command_a, :command_l, :command_r

  def initialize(command)
    @command_a = command[:command_a]
    @command_l = command[:command_l]
    @command_r = command[:command_r]
    # @command = command
  end

  def self.make_command
    options = ARGV.getopts('a', 'l', 'r')
    Command.new(command_a: options['a'], command_l: options['l'], command_r: options['r'])
  end

  def command_a?
    @command_a
  end

  def command_r?
    @command_r
  end

  def command_l?
    @command_l
  end
end
