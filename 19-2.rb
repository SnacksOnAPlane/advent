require 'pry'
require 'set'

$repls = Hash.new {|h,k| h[k] = Array.new }

File.readlines("19.data").each do |line|
  mol, repl = line.chomp.split(" => ")
  $repls[repl.split(/(?=[A-Z])/).join("-")] << mol
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

inputs = ['-' + start.split(/(?=[A-Z])/).join("-") + '-']

i = 0
while true
  new_inputs = Set.new
  i += 1
  inputs.to_a.each do |input|
    puts "#{input}"
    ps = possibles(input)
    new_inputs = new_inputs + ps
    ps.each do |p|
      if p == '-e-'
        raise "got it at #{i}"
      end
    end
  end
  inputs = new_inputs
end
