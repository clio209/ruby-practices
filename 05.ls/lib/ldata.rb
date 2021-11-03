# frozen_string_literal: true

require_relative './filename'
require_relative './lsfile'

class Ldata
  def initialize(ls_files)
    @ls_files = ls_files
  end

  def make_data_l
    @ls_files.map {|ls_file| ls_file.l_line}
  end
end
