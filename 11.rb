$consec_letters = []
('a'..'z').each_cons(3) { |l| $consec_letters << l.join('') }

$pair_letters = []
('a'..'z').each { |l| $pair_letters << (l+l) }

def increment(pw)
  num = pw.tr( "abcdefghijklmnopqrstuvwxyz", "0123456789abcdefghijklmnopq" ).to_i(26)
  num += 1
  num.to_s(26).tr( "0123456789abcdefghijklmnopq", "abcdefghijklmnopqrstuvwxyz" )
end

def has_3_consec_letters(pw)
  $consec_letters.each do |l|
    return true if pw.include? l
  end
  false
end

def does_not_contain_invalids(pw)
  return false if pw.include?('i') || pw.include?('o') || pw.include?('l')
  true
end

def has_two_pairs_of_letters(pw)
  num_pairs = 0
  $pair_letters.each do |l|
    num_pairs += 1 if pw.include?(l)
    return true if num_pairs == 2
  end
  false
end

def is_valid(pw)
  puts "checking #{pw}"
  has_3_consec_letters(pw) && does_not_contain_invalids(pw) && has_two_pairs_of_letters(pw)
end

def go
  # part 1
  # input = "hxbxwxba"
  input = "hxbxxyzz"

  while true
    input = increment(input)
    break if is_valid(input)
  end

  puts input
end

go
