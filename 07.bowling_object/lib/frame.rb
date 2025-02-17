# frozen_string_literal: true

class Frame
  def initialize(number, first_mark, second_mark = nil, third_mark = nil)
    @number = number
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    [@first_shot.score, @second_shot.score, @third_shot.score].sum
  end

  def first_score
    @first_shot.score
  end

  def second_score
    @second_shot.score
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    @first_shot.score != 10 && @first_shot.score + @second_shot.score == 10
  end

  def last_frame?
    @number == 10
  end
end
