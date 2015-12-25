require 'pry'

$registers = {
  a: 1,
  b: 0
}

prog = []
File.readlines("23.data").each do |line|
  ins, data = line.chomp.split(" ", 2)
  prog << [ins, data]
end

def get_register(reg)
  $registers[reg.to_sym]
end

def set_register(reg, val)
  puts "set #{reg} to #{val}"
  $registers[reg.to_sym] = val
end

def process_data(prog)
  i = 0
  while true
    puts i
    if i >= prog.length
      break
    end
    d = prog[i]
    p d
    p $registers
    ins, data = d
    if ins == "hlf"
      set_register(data, get_register(data) / 2)
      i += 1
    elsif ins == "tpl"
      set_register(data, get_register(data) * 3)
      i += 1
    elsif ins == "inc"
      set_register(data, get_register(data) + 1)
      i += 1
    elsif ins == "jmp"
      i = i + data.to_i
    elsif ins == "jie"
      reg, offset = data.split(', ')
      if get_register(reg) % 2 == 0
        i = i + offset.to_i
      else
        i += 1
      end
    elsif ins == "jio"
      reg, offset = data.split(', ')
      if get_register(reg) == 1
        i = i + offset.to_i
      else
        i += 1
      end
    end
  end
end

process_data(prog)
puts $registers[:b]
