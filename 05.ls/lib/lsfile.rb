# frozen_string_literal: true

require_relative './filename'

class LsFile
  def initialize(filename)
    @stat = File.stat(filename)
    @filename = filename
  end

  FILE_TYPE = { 'file' => '-', 'directory' => 'd', 'link' => 'l' }.freeze
  PERMISSION = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-',
                 '7' => 'rwx' }.freeze

  def mode_permission(mode_input)
    mode_input.map { |mode| PERMISSION[mode] }.join
  end

  def mode
    mode_permission(@stat.mode.to_s(8).slice(/\d{3}$/).split(//))
  end

  def owner
    @stat.nlink.to_s
  end

  def file_size
    @stat.size.to_s
  end

  def last_updated
    @stat.mtime.strftime('%m %d %R')
  end

  attr_reader :filename

  def l_line
    "#{FILE_TYPE[@stat.ftype]}#{mode} #{owner.rjust(4)}  #{Etc.getpwuid(@stat.uid).name} #{Etc.getgrgid(@stat.gid).name} #{file_size.rjust(5)} #{last_updated} #{filename}\n"
  end
end
