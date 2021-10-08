# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'
require_relative '../lib/shot'
require_relative '../lib/frame'

class BowlingTest < Minitest::Test
  def test_bowling
    game1 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    game2 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X')
    game3 = Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    game4 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    game5 = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')

    assert_equal 139, game1.point
    assert_equal 164, game2.point
    assert_equal 107, game3.point
    assert_equal 134, game4.point
    assert_equal 300, game5.point
  end
end
