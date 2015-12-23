require 'pry'

$spells = {
  'Magic Missile' => { cost: 53, damage: 4 },
  'Drain' => { cost: 73, damage: 2, heal: 2 },
  'Shield' => { cost: 113, effect: { turns: 6, armor: 7 } },
  'Poison' => { cost: 173, effect: { turns: 6, damage: 3 } },
  'Recharge' => { cost: 229, effect: { turns: 5, mana: 101 } }
}

$spells.each { |k, v| v[:name] = k }

$active_effects = []

def print_summary
  puts "- Player has #{$player[:hp]} hit points, #{$player[:armor]} armor, #{$player[:mana]} mana"
  puts "- Boss has #{$boss[:hp]} hit points"
end

def apply_immediates(spell)
  $boss[:hp] -= spell.fetch(:damage, 0)
  $player[:hp] += spell.fetch(:heal, 0)
  if spell[:effect]
    $active_effects << spell[:effect].clone.merge(name: spell[:name])
  end
  $player[:mana] -= spell[:cost]
  $spent += spell[:cost]
end

def apply_effects(output)
  puts "Applying effects:" if output
  p $active_effects if output
  $player[:armor] = 0
  $active_effects.each do |effect|
    $player[:armor] += effect.fetch(:armor, 0)
    $player[:mana] += effect.fetch(:mana, 0)
    $boss[:hp] -= effect.fetch(:damage, 0)
    effect[:turns] -= 1
  end
  $active_effects = $active_effects.select { |effect| effect[:turns] > 0 }
end

def active_effects_contains_dupes
  names = $active_effects.map { |e| e[:name] }
  names.uniq.length != names.length
end

def get_winner
  return "Boss" if $player[:hp] <= 0 || $player[:mana] < 0 || active_effects_contains_dupes
  return "Player" if $boss[:hp] <= 0
end

def play(spell, output = false)
  puts "-- Player turn --" if output
  print_summary if output
  puts "Player casts #{spell}" if output
  $player[:hp] -= 1
  if winner = get_winner
    return winner
  end
  spell = $spells[spell]
  apply_effects(output)
  apply_immediates(spell)
  if winner = get_winner
    return winner
  end

  puts "-- Boss turn --" if output
  apply_effects(output)
  print_summary if output
  if winner = get_winner
    return winner
  end
  boss_damage = [1,$boss[:damage] - $player[:armor]].max
  $player[:hp] -= boss_damage
  puts "Boss attacks for #{boss_damage} damage!" if output
  if winner = get_winner
    return winner
  end
end

def player_wins(attacks)
  attacks.each do |attack|
    if winner = play(attack, false) 
      return winner == "Player"
    end
  end
  return false
end

def generate_attacks(len)
  retme = []
  return $spells.keys.map { |s| [s] } if len == 1
  $spells.keys.each do |spell|
    generate_attacks(len-1).each do |attack|
      retme << [spell] + attack
    end
  end
  retme
end

def get_cost(attack)
  attack.reduce(0) { |sum, spell| sum + $spells[spell][:cost] }
end

attacks = generate_attacks(8).sort_by(&method(:get_cost))
attacks_len = attacks.length

attacks.each_with_index do |attack, i|
  $active_effects = []
  $player = { hp: 50, mana: 500, armor: 0 }
  $boss = { hp: 51, damage: 9 }
  $spent = 0
  puts "#{i}/#{attacks_len}"
  p attack
  if player_wins(attack)
    puts "Player wins, costing #{$spent}"
    break
  end
end
