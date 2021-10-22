# frozen_string_literal: true

require_relative './basedata'
require_relative './command'
require_relative './ldata'

class Output
  # attr_reader :command

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

  # def mode_permission(mode_input)
  #   permission_info = []
  #   mode_input.each do |mode|
  #     permission_info << PERMISSION[mode]
  #   end
  #   permission_info.join
  # end

  # def output_l
  #   total = @base_data.sum { |arr| File.stat(arr).blocks }
  #   puts "total #{total}"
  #   @base_data.each do |filename|
  #     data = File.stat(filename)
  #     mode = mode_permission(data.mode.to_s(8).slice(/\d{3}$/).split(//))
  #     owner = data.nlink.to_s.rjust(4)
  #     file_size = data.size.to_s.rjust(5)
  #     last_updated = data.mtime.strftime('%m %d %R')
  #     print "#{FILE_TYPE[data.ftype]}#{mode} #{owner}  #{Etc.getpwuid(data.uid).name} #{Etc.getgrgid(data.gid).name} #{file_size} #{last_updated} #{filename}\n"
  #   end
  # end

  def output_l
    ldata = Ldata.new
    @l_data = ldata.data_l
    @l_data.each {|data| puts data}
  end


  def output
    if @command.command_l?
      output_l
    else
      output_normal
    end
    p @base_data
  end
end
