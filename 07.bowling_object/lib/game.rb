# frozen_string_literal: true

require_relative './frame'
require_relative './shot'

class Game
  attr_reader :frames

  def initialize(score)
    @frames = make_scores(score)
  end

  def make_scores(score)
    scores = score.split(',')
    frames = []
    9.times do
      first = scores.shift
      if first == 'X'
        frames << Frame.new('X')
      else
        second = scores.shift
        frames << Frame.new(first, second)
      end
    end
    frames << Frame.new(scores[0], scores[1], scores[2])
  end

  def add_point_strike
    @frames.each_with_index.sum(0) do |frame, i|
      if frame.strike? && i <= 7
        if @frames[i.next].strike?
          @frames[i.next].first_score + @frames[i.next.next].first_score
        else
          @frames[i.next].score
        end
      elsif frame.strike? && i <= 8
        @frames[i.next].first_score + @frames[i.next].second_score
      else 0
      end
    end
  end

  def add_point_spare
    @frames.each_with_index.sum(0) do |frame, i|
      if frame.spare? && i <= 8
        @frames[i.next].first_score
      else 0
      end
    end
  end

  def calculate_point
    @frames.each_with_index.sum(0) do |frame, _i|
      frame.score
    end
  end

  def point
    p calculate_point
    p add_point_strike
    p add_point_spare
    @point ||= calculate_point + add_point_strike + add_point_spare
  end
end
