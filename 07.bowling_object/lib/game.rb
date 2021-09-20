# frozen_string_literal: true

require_relative './frame'
require_relative './shot'

class Game < Frame
  def initialize(score)
    @score = score
  end

  def devide_score(score)
    scores = score.split(',')
    @frames = []
    9.times do
      first = scores.shift
      if first == 'X'
        @frames << ['X']
      else
        second = scores.shift
        @frames << [first, second]
      end
    end
    @frames << scores
  end

  def make_frame
    devide_score(@score)
    @scores_array = []
    @frames.each do |data|
      frame = Frame.new(data[0], data[1], data[2])
      @scores_array << frame.score_frame
    end
  end

  def calculate_point
    make_frame
    @scores_array.each_with_index.sum(0) do |f, i|
      if f[0] == 10 && i <= 7
        if @scores_array[i.next][0] == 10
          10 + @scores_array[i.next][0] + @scores_array[i.next.next][0]
        else
          10 + @scores_array[i.next][0] + @scores_array[i.next][1]
        end
      elsif f[0] == 10 && i <= 8
        10 + @scores_array[i.next][0] + @scores_array[i.next][1]
      elsif f.sum == 10 && i <= 8
        10 + @scores_array[i.next][0]
      else
        f.sum
      end
    end
  end
end

game1 = Game.new(ARGV[0])
puts game1.calculate_point
