require 'pry'

container_sizes = []
File.readlines("17-1.data").each_with_index do |line, i|
  container_sizes << line.chomp.to_i
end

def find_combinations(containers, size)
  if size == 0
    return [[]]
  elsif size < 0
    return false
  end
  if containers.length == 1
    if containers[0] == size
      return [[containers[0]]]
    else
      return false
    end
  end
  retme = []
  containers.each_with_index do |c, i|
    combos = find_combinations(containers[i+1..-1], size - c)
    if combos != false
      combos.each do |combo|
        good = [c] + combo
        retme << good
      end
    end
  end
  retme
end

combos = find_combinations(container_sizes, 150)
min_containers = combos.map { |c| c.length }.min
puts combos.select { |c| c.length == min_containers }.length
