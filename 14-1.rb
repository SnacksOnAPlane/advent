require 'pry'

$reindeer_speeds = {}
$reindeer_dists = {}
$reindeer_points = Hash.new(0)

File.readlines("14-1.data").each do |line|
  match = /(.*) can fly (.*) km\/s for (.*) seconds, but then must rest for (.*) seconds./.match(line.chomp)
  name = match[1]
  speed = match[2].to_i
  secs = match[3].to_i
  rest = match[4].to_i
  $reindeer_speeds[name] = [speed, secs, rest]
end

def award_points
  max_dist = 0
  reindeer = []
  $reindeer_dists.each do |name, dist|
    if dist > max_dist
      max_dist = dist
      reindeer = [name]
    elsif dist == max_dist
      reindeer << name
    end
  end
  reindeer.each { |r| $reindeer_points[r] += 1 }
end

(1..2503).each do |t|
  $reindeer_speeds.each do |name, info|
    speed, secs, rest = info
    interval = secs + rest
    dist_per_interval = speed * secs
    num_intervals = t / interval
    secs_into_interval = t % interval
    if secs_into_interval > secs
      total_dist = (num_intervals + 1) * dist_per_interval
    else
      total_dist = num_intervals * dist_per_interval + (secs_into_interval * dist_per_interval) / secs
    end
    $reindeer_dists[name] = total_dist
  end
  award_points
end

puts $reindeer_dists
puts $reindeer_points
