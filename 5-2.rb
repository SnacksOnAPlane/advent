require 'pry'

def containsPairOccuringTwice(line)
  pair_positions = Hash.new { |h, k| h[k] = [] }
  (0..line.length-2).each do |p|
    pair = line[p..p+1]
    pair_positions[pair] << p
  end

  pair_positions.values.each do |positions|
    return true if positions.max - positions.min > 1
  end
  return false
end

def containsRepeatLetterWithOneLetterBetween(line)
  (0..line.length-3).each do |p|
    return true if line[p] == line[p+2]
  end
  return false
end

nice_lines = 0

def isNiceString(line)
  containsPairOccuringTwice(line) && containsRepeatLetterWithOneLetterBetween(line)
end

File.readlines("5-1.data").each do |line|
  puts line
  if isNiceString(line)
    puts "nice"
    nice_lines += 1
  end
end

puts nice_lines
