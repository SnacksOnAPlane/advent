require 'pry'

$weights = []

File.readlines("24.data").each do |line|
  $weights << line.chomp.to_i
end

total_weight = $weights.reduce(:+)
section_weight = total_weight / 4
puts "section_weight: #{section_weight}"

def combos_adding_to(items, weight)
  retme = []
  (4..8).each do |i|
    puts "trying #{i}"
    items.combination(i).each do |combo|
      s = combo.reduce(:+)
      retme << combo if s == weight
    end
    break unless retme.empty?
  end
  retme
end

combos = combos_adding_to($weights, section_weight)
quanta = combos.map { |c| c.reduce(:*) }
puts quanta.min
