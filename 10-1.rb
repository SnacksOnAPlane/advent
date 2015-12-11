num = "1113122113"
require 'pry'

def transform(input)
  curr_digit = input[0]
  count = 1
  output = []
  input[1..-1].split("").each do |c|
    if c == curr_digit
      count += 1
    else
      output << "#{count}#{curr_digit}"
      count = 1
    end
    curr_digit = c
  end
  output << "#{count}#{curr_digit}"
  output.join("")
end

output = transform(num)
puts output
49.times do
  output = transform(output)
  puts output
end

puts output.length
