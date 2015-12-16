require 'pry'

sue = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1
}

$data = {}

File.readlines("16-1.data").each do |line|
  name, items = line.chomp.split(": ", 2)
  $data[name] = {}
  items.split(", ").each do |item|
    type, num = item.split(": ")
    num = num.to_i
    $data[name][type] = num
  end
end

$data.each do |name, items|
  her = true
  items.each do |item, num|
    if ['cats','trees'].include? item
      if sue[item.to_sym] >= num
        her = false
      end
    elsif ['pomeranians','goldfish'].include? item
      if sue[item.to_sym] <= num
        her = false
      end
    else
      if sue[item.to_sym] != num
        her = false
      end
    end
  end
  puts name if her
end
