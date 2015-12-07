require 'pry'

$wires = {}

File.readlines("7-1.data").each do |line|
  op, wire = line.split(' -> ')
  $wires[wire.chomp] = op
end

def get_value(wire)
  return wire.to_i if wire.to_i.to_s == wire
  value = $wires[wire]
  return value if value.is_a? Integer
  if value.to_i.to_s == value
    $wires[wire] = value.to_i
    return value.to_i
  end
  parts = value.split
  if parts[0] == "NOT"
    $wires[wire] = ~get_value(value.split[1])
  elsif parts.count == 1
    $wires[wire] = get_value(parts[0])
  elsif parts.count == 3
    w1, oper, w2 = parts
    if oper == "AND"
      $wires[wire] = get_value(w1) & get_value(w2)
    elsif oper == "OR"
      $wires[wire] = get_value(w1) | get_value(w2)
    elsif oper == "LSHIFT"
      $wires[wire] = get_value(w1) << w2.to_i
    elsif oper == "RSHIFT"
      $wires[wire] = get_value(w1) >> w2.to_i
    end
  else
    puts "malformed input: #{value}"
  end
  return $wires[wire]
end

$wires['b'] = 956
puts get_value('a')
