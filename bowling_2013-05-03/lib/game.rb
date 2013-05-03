class Game

  def initialize
    @rolls = []
  end

  def roll(pins)
    raise if @rolls.size >= 20
    @rolls.push pins
    @rolls.push 0 if pins == 10
  end

  def score
    @score = 0
    spare  = false
    strike = false

    @rolls.each_slice(2) do |frame|
      sum = frame.inject 0, &:+
      @score += sum

      case
      when strike
        @score += sum
      when spare
        @score += frame.first
      end

      spare  = sum == 10
      strike = frame.first == 10
    end
    @score
  end

end
