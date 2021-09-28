# frozen_string_literal: true

require_relative './frame'
require_relative './shot'

class Game
  def initialize(score)
    @score = score
  end

  def devide_score(score)
    scores = score.split(',')
    @devided_scores = []
    9.times do
      first = scores.shift
      if first == 'X'
        @devided_scores << ['X']
      else
        second = scores.shift
        @devided_scores << [first, second]
      end
    end
    @devided_scores << scores

  end

  def make_frame
    devide_score(@score)
    @frames = []
    @devided_scores.each do |data|
      frame = Frame.new(data[0], data[1], data[2])
      @frames << frame
    end
  end

  def calculate_point
    make_frame
    @frames.each_with_index.sum(0) do |frame, i|
      if frame.first == 10 && i <= 7
        if @frames[i.next].first == 10
          10 + @frames[i.next].first + @frames[i.next.next].first
        else
          10 + @frames[i.next].first + @frames[i.next].second
        end
      elsif frame.first == 10 && i <= 8
        10 + @frames[i.next].first + @frames[i.next].second
      elsif frame.frame_score == 10 && i <= 8
        10 + @frames[i.next].first
      else
        frame.frame_score
      end
    end
  end
end

game1 = Game.new(ARGV[0])
puts game1.calculate_point
