require 'pry'

$ingredients = {}
$calories = {}

File.readlines("15-1.data").each do |line|
  match = /(.*): capacity (.*), durability (.*), flavor (.*), texture (.*), calories (.*)/.match(line.chomp)
  _, ingredient, capacity, durability, flavor, texture, calories = match.to_a
  $ingredients[ingredient] = [capacity, durability, flavor, texture].map(&:to_i)
  $calories[ingredient] = calories.to_i
end

def total_score(ingredient_amts)
  retme = 0
  props = [0,0,0,0]
  calories = 0
  ingredient_amts.each do |ing, amt|
    calories += $calories[ing] * amt
    ing_amt = $ingredients[ing].map { |x| x * amt }
    props = [props,ing_amt].transpose.map {|x| x.reduce(:+)}
  end
  return 0 if calories != 500
  props = props.map { |p| [0,p].max }
  props.reduce(&:*)
end

def all_distributions(arr, remaining)
  return [[remaining]] if arr.length == 1
  retme = []
  (0..remaining).each do |i|
    all_distributions(arr[1..-1], remaining - i).each do |d|
      retme << ([i] + d)
    end
  end
  retme
end

all_ingredients = $ingredients.keys
all_dists = all_distributions(Array.new(all_ingredients.length, 0), 100)
high_score = 0

all_dists.each do |d|
  dist = Hash[*all_ingredients.zip(d).flatten]
  score = total_score(dist)
  puts "#{score} #{dist}"
  high_score = [high_score, score].max
end

puts high_score
