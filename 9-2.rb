distances = Hash.new{ |h,k| h[k] = Hash.new }

File.readlines("9-1.data").each do |line|
  line = line.chomp
  places, dist = line.split(" = ")
  dist = dist.to_i
  p1, p2 = places.split(" to ")
  distances[p1][p2] = dist
  distances[p2][p1] = dist
end

longest_dist = 0
longest_perm = nil

distances.keys.permutation.each do |perm|
  dist = 0
  (0..perm.length - 2).each do |i|
    p1 = perm[i]
    p2 = perm[i+1]
    dist += distances[p1][p2]
  end
  if dist > longest_dist
    puts "new longest dist: #{dist}"
    longest_dist = dist
    longest_perm = perm
  end
end

puts longest_dist
