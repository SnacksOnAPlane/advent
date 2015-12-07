house_grid = Hash.new { |h,k| h[k] = Hash.new(0) }

x = 0
y = 0
rsx = 0
rsy = 0

house_grid[x][y] += 1
house_grid[rsx][rsy] += 1

rs = false

File.readlines("3-1.data").each do |line|
  line.chars.each do |c|
    if c == '^'
      if rs
        rsy += 1
      else
        y += 1
      end
    elsif c == 'v'
      if rs
        rsy -= 1
      else
        y -= 1
      end
    elsif c == '>'
      if rs
        rsx += 1
      else
        x += 1
      end
    elsif c == '<'
      if rs
        rsx -= 1
      else
        x -= 1
      end
    end

    if rs
      house_grid[rsx][rsy] += 1
    else
      house_grid[x][y] += 1
    end
    rs = !rs
  end
end

retme = 0
house_grid.each_pair do |x, col|
  retme += col.keys.count
end

puts retme
