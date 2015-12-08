code_chars = 0
esc_chars = 0

File.readlines("8-1.data").each do |line|
  line = line.chomp
  code_chars += line.length
  esc_chars += line.dump.length
end

puts esc_chars - code_chars
