require 'pry'

$state = []

File.readlines("18-1.data").each do |line|
  $state << line.chomp.chars
end

$max_i = $state.length
$max_j = $state[0].length

def num_neighbors_on(i, j)
  possible_neighbors = [[i-1, j-1], [i-1, j], [i-1, j+1], [i, j-1], [i, j+1], [i+1, j-1], [i+1, j], [i+1, j+1]]
  neighbors = possible_neighbors.select { |pos| pos[0] >= 0 && pos[0] < $max_i && pos[1] >= 0 && pos[1] < $max_j }
  neighbors.inject(0) do |sum, pos|
    pos_sym = $state[pos[0]][pos[1]]
    add = (pos_sym == '#' ? 1 : 0)
    sum + add
  end
end

def transition_state(state)
  retme = []
  state.each_with_index do |row, i|
    retrow = []
    row.each_with_index do |pos, j|
      pos_on = (pos == '#')
      neighbors_on = num_neighbors_on(i, j)
      if pos_on
        retrow << ([2,3].include?(neighbors_on) ? '#' : '.')
      else
        retrow << ((3 == neighbors_on) ? '#' : '.')
      end
    end
    retme << retrow
  end
  retme
end

def print_state(state)
  state.each { |row| p row.join('') }
end

def set_corners
  $state[0][0] = '#'
  $state[0][$max_j - 1] = '#'
  $state[$max_i - 1][0] = '#'
  $state[$max_i - 1][$max_j - 1] = '#'
end

100.times do
  set_corners
  $state = transition_state($state)
end

set_corners

count = $state.inject(0) do |sum, row|
  sum + row.inject(0) do |isum, pos|
    isum + (pos == '#' ? 1 : 0)
  end
end

p count
