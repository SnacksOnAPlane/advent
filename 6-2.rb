require 'pry'

$lights = Array.new(1000)
(0..999).each do |i|
  $lights[i] = Array.new(1000, 0)
end

def positions(start_pos, end_pos)
  start_x, start_y = start_pos.split(',').map(&:to_i)
  end_x, end_y = end_pos.split(',').map(&:to_i)
  (start_x..end_x).each do |x|
    (start_y..end_y).each do |y|
      yield(x, y)
    end
  end
end

def switchTo(bool, start_pos, end_pos)
  if bool
    positions(start_pos, end_pos) { |x,y| $lights[x][y] += 1 }
  else
    positions(start_pos, end_pos) do |x,y|
      $lights[x][y] -= 1
      $lights[x][y] = 0 if $lights[x][y] < 0
    end
  end
end

def toggle(start_pos, end_pos)
  positions(start_pos, end_pos) { |x,y| $lights[x][y] = $lights[x][y] + 2 }
end

File.readlines("6-1.data").each do |line|
  area_parts = line.split[-3..-1]
  start_pos = area_parts[0]
  end_pos = area_parts[2]
  if line.start_with? "turn on"
    switchTo(true, start_pos, end_pos)
  elsif line.start_with? "turn off"
    switchTo(false, start_pos, end_pos)
  elsif line.start_with? "toggle"
    toggle(start_pos, end_pos)
  end
end

total_bright = 0

$lights.each do |col|
  col.each { |l| total_bright += l }
end

puts total_bright
