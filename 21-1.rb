require 'pry'
require 'set'

$items = Hash.new { |h, k| h[k] = [] }

klass = nil
File.readlines("21.data").each do |line|
  line = line.chomp
  if line.include? ':'
    klass = line.split(':')[0]
    next
  end
  next if line.empty?
  name, cost, damage, armor = line.split(/\s{2,}/)
  $items[klass] << { name: name, cost: cost.to_i, damage: damage.to_i, armor: armor.to_i }
end

def play_round
  $boss_stats[:hp] -= [1, ($my_stats[:damage] - $boss_stats[:armor])].max
  puts "Boss HP: #{$boss_stats[:hp]}"
  return if $boss_stats[:hp] <= 0
  $my_stats[:hp] -= [1, ($boss_stats[:damage] - $my_stats[:armor])].max
  puts "My HP: #{$my_stats[:hp]}"
end

def win?
  while $my_stats[:hp] > 0 && $boss_stats[:hp] > 0
    play_round
  end
  $my_stats[:hp] > 0 && $boss_stats[:hp] <= 0
end

def item_combos
  retme = []
  # first try only weapons
  retme += $items['Weapons'].map { |w| [w] }
  # each weapon + each armor
  $items['Weapons'].each { |w| $items['Armor'].each { |a| retme << [w,a] } }
  # each weapon + 1 ring
  $items['Weapons'].each { |w| $items['Rings'].each { |r| retme << [w,r] } }
  # each weapon + 2 rings
  $items['Weapons'].each { |w| $items['Rings'].combination(2) { |r| retme << ([w] + r) } }
  # each weapon + each armor + 1 ring
  $items['Weapons'].each { |w| $items['Armor'].each { |a| $items['Rings'].each { |r| retme << [w,a,r] } } }
  # each weapon + each armor + 2 rings
  $items['Weapons'].each { |w| $items['Armor'].each { |a| $items['Rings'].combination(2) { |r| retme << ([w,a] + r) } } }
  retme
end

def get_price(combo)
  combo.reduce(0) { |sum, item| sum + item[:cost] }
end

combos = item_combos
item_combos.sort_by(&method(:get_price)).each do |item_combo|
  $my_stats = { hp: 100 }
  $boss_stats = { hp: 109, damage: 8, armor: 2 }
  cost = item_combo.reduce(0) { |sum, item| sum + item[:cost] }
  $my_stats[:damage] = item_combo.reduce(0) { |sum, item| sum + item[:damage] }
  $my_stats[:armor] = item_combo.reduce(0) { |sum, item| sum + item[:armor] }
  binding.pry if win?
end
