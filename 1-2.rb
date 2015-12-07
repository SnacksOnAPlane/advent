#!/usr/bin/env ruby -w

moves = File.read("1-2.moves")

floor = 0
moves.chars.each_with_index do |c, i|
  if c == "("
    floor += 1
  else
    floor -= 1
  end
  if floor == -1
    puts i+1
    break
  end
end
