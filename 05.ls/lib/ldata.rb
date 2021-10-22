require_relative './basedata'
require_relative './command'

class Ldata
  attr_reader :base_data , :command

  def initialize
    basedata = BaseData.new
    @base_data = basedata.make_data
    @command = basedata.command
  end

  FILE_TYPE = { 'file' => '-', 'directory' => 'd', 'link' => 'l' }.freeze
  PERMISSION = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-',
                 '7' => 'rwx' }.freeze

  def mode_permission(mode_input)
    permission_info = []
    mode_input.each do |mode|
      permission_info << PERMISSION[mode]
    end
    permission_info.join
  end

  def data_l
    @l_data = []
    total = @base_data.sum { |arr| File.stat(arr).blocks }
    puts "total #{total}"
    @base_data.each do |filename|
      data = File.stat(filename)
      mode = mode_permission(data.mode.to_s(8).slice(/\d{3}$/).split(//))
      owner = data.nlink.to_s.rjust(4)
      file_size = data.size.to_s.rjust(5)
      last_updated = data.mtime.strftime('%m %d %R')
      @l_data << "#{FILE_TYPE[data.ftype]}#{mode} #{owner}  #{Etc.getpwuid(data.uid).name} #{Etc.getgrgid(data.gid).name} #{file_size} #{last_updated} #{filename}\n"
    end
    p @base_data
    @l_data
  end

end

# ldata1 = Ldata.new
# ldata1.data_l
