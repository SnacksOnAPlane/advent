require 'prime'
require 'pry'

input = 33100000

def factors_of(number)
  primes, powers = number.prime_division.transpose
  exponents = powers.map{|i| (0..i).to_a}
  divisors = exponents.shift.product(*exponents).map do |powers|
    primes.zip(powers).map{|prime, power| prime ** power}.inject(:*)
  end
  divisors
end

def get_num_gifts(house_num)
  factors_of(house_num).reduce(0) { |sum, factor| sum + factor * 10 }
end


house_num = 1
while true
  house_num += 1
  num_gifts = get_num_gifts(house_num)
  puts "#{house_num}\t#{num_gifts}"
  if num_gifts >= input
    break
  end
end
