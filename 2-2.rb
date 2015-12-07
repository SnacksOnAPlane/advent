total_length = 0

File.readlines("2-1.data").each do |line|
  lengths = line.split("x").map(&:to_i).sort
  puts lengths
  volume = lengths.reduce(&:*)
  total_length += lengths[0] * 2 + lengths[1] * 2 + volume
end

puts total_length
