require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game'

class GameTest < MiniTest::Unit::TestCase
  attr_reader :game

  def setup
    @game = Game.new
  end

  def test_all_zero
    roll_many 20, 0

    assert_equal 0, game.score
  end

  def test_one_pin
    game.roll 1
    roll_many 19, 0

    assert_equal 1, game.score
  end

  def test_each_roll_one_pin
    roll_many 20, 1

    assert_equal 20, game.score
  end

  def test_one_spare
    game.roll 5
    game.roll 5
    game.roll 3
    roll_many 17, 0

    assert_equal 16, game.score
  end

  def test_one_strike
    game.roll 10
    game.roll 3
    game.roll 4
    roll_many 16, 0

    assert_equal 24, game.score
  end

  def test_spare_and_strike
    game.roll 4
    game.roll 6
    game.roll 3
    game.roll 5
    game.roll 10
    game.roll 1
    game.roll 8
    roll_many 12, 0

    assert_equal 49, game.score
  end

  def test_end_of_game
    roll_many 20, 0

    assert_raises(RuntimeError) { game.roll 0 }
  end

  def test_end_of_game_after_ten_strike
    roll_many 10, 10

    assert_raises(RuntimeError) { game.roll 0 }
  end

private
  def roll_many(round, pin)
    round.times { game.roll(pin) }
  end
end
