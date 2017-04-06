class DiceSet
  attr_reader :dice_values
  attr_reader :num_non_scoring

  def initialize
    @dice_values = []
    @num_non_scoring = 5
    @num_scoring = 0
  end

  def roll(num_of_dice)
    @dice_values = []
    @num_non_scoring = num_of_dice
    @num_scoring = 0
    
    num_of_dice.times { @dice_values << rand(1..6) }
    @dice_values
  end

  def score
    points = 0
    counts = Hash.new(0)

    @dice_values.each do |value|
      counts[value] = counts[value] ? counts[value] + 1 : 1
    end

    counts.each do |key, value|
      points += case key
      when 1
        handle_ones value
      when 5
        handle_fives value
      else
        handle_others key, value
      end
    end

    puts "Scoring dices: #{@num_scoring}"
    @num_non_scoring = @num_non_scoring - @num_scoring
    points
  end

  def display_dice_values
    puts @dice_values.join(', ')
  end

  private

  def handle_ones(value)
    three_ones, other_ones = value.divmod 3
    @num_scoring += 3 * three_ones + other_ones
    ones_score = 1000 * three_ones + 100 * other_ones
    ones_score
  end

  def handle_fives(value)
    three_fives, other_fives = value.divmod 3
    @num_scoring += 3 * three_fives + other_fives
    fives_score = 500 * three_fives + 50 * other_fives
    fives_score
  end

  def handle_others(key, value)
    three_nums, = value.divmod 3
    @num_scoring += 3 * three_nums
    others_score = key * 100 * three_nums
    others_score
  end
end
