require 'pry'
require 'set'

$repls = {}

File.readlines("19.data").each do |line|
  mol, repl = line.chomp.split(" => ")
  $repls['-' + repl.split(/(?=[A-Z])/).join("-") + '-'] = "-#{mol}-"
end

start = "CRnSiRnCaPTiMgYCaPTiRnFArSiThFArCaSiThSiThPBCaCaSiRnSiRnTiTiMgArPBCaPMgYPTiRnFArFArCaSiRnBPMgArPRnCaPTiRnFArCaSiThCaCaFArPBCaCaPTiTiRnFArCaSiRnSiAlYSiThRnFArArCaSiRnBFArCaCaSiRnSiThCaCaCaFYCaPTiBCaSiThCaSiThPMgArSiRnCaPBFYCaCaFArCaCaCaCaSiThCaSiRnPRnFArPBSiThPRnFArSiRnMgArCaFYFArCaSiRnSiAlArTiTiTiTiTiTiTiRnPMgArPTiTiTiBSiRnSiAlArTiTiRnPMgArCaFYBPBPTiRnSiRnMgArSiThCaFArCaSiThFArPRnFArCaSiRnTiBSiThSiRnSiAlYCaFArPRnFArSiThCaFArCaCaSiThCaCaCaSiRnPRnCaFArFYPMgArCaPBCaPBSiRnFYPBCaFArCaSiAl"

#start = "HOHOHO"

def replace_each(input, str, replacement)
  retme = []
  matches = input.match(str)
  if matches
    (0..(matches.length - 1)).each do |m_n|
      start, fin = matches.offset(m_n)
      if start == 0
        retme << replacement + input[fin..-1]
      elsif fin == input.length - 1
        retme << input[0..start - 1] + replacement
      else
        retme << input[0..start - 1] + replacement + input[fin..-1]
      end
    end
  end
  retme
end

def possibles(input)
  possibilities = Set.new
  $repls.each do |s, es|
    s = "-#{s}-"
    es.each do |e|
      e = "-#{e}-"
      possibilities += replace_each(input, s, e)
    end
  end
  possibilities
end

def replace_longest_match(input)
  $repls.keys.sort_by { |k| -k.length }.each do |k|
    if input.include? k
      puts "#{k} -> #{$repls[k]}"
      input[k] = $repls[k]
      return input
    end
  end
  input
end

input = '-' + start.split(/(?=[A-Z])/).join("-") + '-'

i = 0
while true
  i += 1
  input = replace_longest_match(input)
  puts input
  if input == '-e-'
    puts i
    break
  end
end
