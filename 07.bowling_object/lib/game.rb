# frozen_string_literal: true

require_relative './frame'
require_relative './shot'

class Game
  def initialize(score)
    @frames = make_frames(score)
  end

  def make_frames(score)
    scores = score.split(',')
    frames = []
    9.times do |i|
      first = scores.shift
      if first == 'X'
        frames << Frame.new(i, 'X')
      else
        second = scores.shift
        frames << Frame.new(i, first, second)
      end
    end
    frames << Frame.new(9, scores[0], scores[1], scores[2])
  end

  def add_point_strike
    @frames[0..8].each_with_index.sum(0) do |frame, i|
      if frame.strike? && !@frames[i.next].last_frame?
        if @frames[i.next].strike?
          10 + @frames[i.next.next].first_score
        else
          @frames[i.next].score
        end
      elsif frame.strike? && @frames[i.next].last_frame?
        @frames[i.next].first_score + @frames[i.next].second_score
      else 0
      end
    end
  end

  def add_point_spare
    @frames[0..8].each_with_index.sum(0) do |frame, i|
      if frame.spare? && !@frames[i.next].last_frame?
        @frames[i.next].first_score
      else 0
      end
    end
  end

  def calculate_point
    @frames.sum(0, &:score)
  end

  def point
    @point ||= calculate_point + add_point_strike + add_point_spare
  end
end
