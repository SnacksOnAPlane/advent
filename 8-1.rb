code_chars = 0
real_chars = 0

File.readlines("8-1.data").each do |line|
  line = line.chomp
  code_chars += line.length
  real_chars += eval(line).length
end

puts code_chars - real_chars
