require 'pry'
require 'json'

def getSumOfNumbers(data)
  puts "testing #{data}"
  if data.class == Hash
    if data.values.include? "red"
      puts "IGNORING RED"
      return 0
    end
    data.values.map { |v| getSumOfNumbers(v) }.inject(&:+)
  elsif data.class == Array
    data.map { |v| getSumOfNumbers(v) }.inject(&:+)
  elsif data.is_a? Numeric
    data
  else
    0
  end
end

File.readlines("12-1.data").each do |line|
  data = JSON.parse(line)
  puts getSumOfNumbers(data)
end
