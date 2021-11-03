# frozen_string_literal: true

require_relative './filename'
require_relative './lsfile'

class Ldata
  def initialize(ls_files)
    @ls_files = ls_files
  end

  # FILE_TYPE = { 'file' => '-', 'directory' => 'd', 'link' => 'l' }.freeze
  # PERMISSION = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-',
  #                '7' => 'rwx' }.freeze
  #
  # def mode_permission(mode_input)
  #   mode_input.map {|mode| PERMISSION[mode] }.join
  # end

  def make_data_l
    @l_data =[]
    # @array_filename.each do |filename|
    #   lsfile = LsFile.new(filename)
    #   @l_data << lsfile.l_line

    @ls_files.each do |filename|
      file = LsFile.new(filename)
      @l_data << file.l_line
    end
  end
    # @l_data
  # end
end
