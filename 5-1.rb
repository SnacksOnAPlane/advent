BAD_STRINGS = ['ab','cd','pq','xy']

def contains3Vowels(line)
  vowel_count = line.count('aeiou')
  return vowel_count >= 3
end

def containsConsecutiveSameLetters(line)
  last_letter = ''
  line.chars.each do |c|
    return true if c == last_letter
    last_letter = c
  end
  return false
end

def containsBadStrings(line)
  BAD_STRINGS.each do |b|
    return true if line.include? b
  end
  return false
end

nice_lines = 0

def isNiceString(line)
  contains3Vowels(line) && containsConsecutiveSameLetters(line) && !containsBadStrings(line)
end

File.readlines("5-1.data").each do |line|
  puts line
  if isNiceString(line)
    puts "nice"
    nice_lines += 1
  end
end

puts nice_lines
