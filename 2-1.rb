total_area = 0

File.readlines("2-1.data").each do |line|
  l,w,h = line.split("x").map(&:to_i)
  side_areas = [l*w, w*h, h*l]
  puts side_areas
  area = 0
  side_areas.each { |a| area += a*2 }
  area += side_areas.min
  total_area += area
end

puts total_area
