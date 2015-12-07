house_grid = Hash.new { |h,k| h[k] = Hash.new(0) }

x = 0
y = 0

house_grid[x][y] += 1
File.readlines("3-1.data").each do |line|
  line.chars.each do |c|
    if c == '^'
      y += 1
    elsif c == 'v'
      y -= 1
    elsif c == '>'
      x += 1
    elsif c == '<'
      x -= 1
    end
    house_grid[x][y] += 1
  end
end

retme = 0
house_grid.each_pair do |x, col|
  retme += col.keys.count
end

puts retme
