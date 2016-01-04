require 'pry'

spotx = 2978
spoty = 3083

"""1 1,1
2 2,1
3 1,2
4 3,1
5 2,2
6 1,3
7 4,1
8 3,2
9 2,3
10 4,1"""

def next_num(input)
  (input * 252533) % 33554393
end

def code_num(x, y)
  layer = x + y - 2
  start = if layer == 0
            1
          else
            1 + (1..layer).inject(:+)
          end
  start + y - 1
end

input = 20151125
(code_num(spotx, spoty) - 1).times do
  input = next_num(input)
end

puts input
