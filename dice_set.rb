class DiceSet
  attr_reader :dice_values
  attr_reader :non_scoring

  def initialize
    @dice_values = []
    @non_scoring = 5
    @scoring = 0
  end

  def roll(num_of_dice)
    @dice_values = []
    @non_scoring = num_of_dice
    @scoring = 0
    
    num_of_dice.times { @dice_values << rand(1..6) }
    @dice_values
  end

  def score
    points = 0
    counts = {}

    @dice_values.uniq.each do |value|
      counts[value] = @dice_values.count value
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

    puts "Scoring dices: #{@scoring}"
    @non_scoring = @non_scoring - @scoring
    points
  end

  def display_dice_values
    puts @dice_values.join(', ')
  end

  private

  def handle_ones(value)
    three_ones, other_ones = value.divmod 3
    @scoring += 3 * three_ones + other_ones
    1000 * three_ones + 100 * other_ones
  end

  def handle_fives(value)
    three_fives, other_fives = value.divmod 3
    @scoring += 3 * three_fives + other_fives
    500 * three_fives + 50 * other_fives
  end

  def handle_others(key, value)
    three_nums, = value.divmod 3
    @scoring += 3 * three_nums
    key * 100 * three_nums
  end
end
