require 'pry'

$happiness = Hash.new{ |h,k| h[k] = Hash.new }

def parseChange(chg)
  num = chg.split(" ")[1].to_i
  if chg.start_with? "lose"
    -num
  else
    num
  end
end

File.readlines("13-1.data").each do |line|
  match = /(.*) would (.*) happiness units by sitting next to (.*)./.match(line.chomp)
  $happiness[match[1]][match[3]] = parseChange(match[2])
end

$happiness.keys.each do |p|
  $happiness[p]["me"] = 0
  $happiness["me"][p] = 0
end

def calcDelta(p1, p2)
  $happiness[p1][p2] + $happiness[p2][p1]
end

max_delta_h = 0
delta_h = 0
$happiness.keys.permutation do |perm|
  delta_h = calcDelta(perm[-1], perm[0])
  (0..perm.length - 2).each do |i|
    delta_h += calcDelta(perm[i], perm[i+1])
  end
  max_delta_h = delta_h if delta_h > max_delta_h
end
puts max_delta_h
