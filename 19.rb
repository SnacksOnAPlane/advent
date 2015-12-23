require 'pry'
require 'set'

$repls = Hash.new {|h,k| h[k] = Array.new }

File.readlines("19.data").each do |line|
  mol, repl = line.chomp.split(" => ")
  $repls[mol] << repl
end

start = "CRnSiRnCaPTiMgYCaPTiRnFArSiThFArCaSiThSiThPBCaCaSiRnSiRnTiTiMgArPBCaPMgYPTiRnFArFArCaSiRnBPMgArPRnCaPTiRnFArCaSiThCaCaFArPBCaCaPTiTiRnFArCaSiRnSiAlYSiThRnFArArCaSiRnBFArCaCaSiRnSiThCaCaCaFYCaPTiBCaSiThCaSiThPMgArSiRnCaPBFYCaCaFArCaCaCaCaSiThCaSiRnPRnFArPBSiThPRnFArSiRnMgArCaFYFArCaSiRnSiAlArTiTiTiTiTiTiTiRnPMgArPTiTiTiBSiRnSiAlArTiTiRnPMgArCaFYBPBPTiRnSiRnMgArSiThCaFArCaSiThFArPRnFArCaSiRnTiBSiThSiRnSiAlYCaFArPRnFArSiThCaFArCaCaSiThCaCaCaSiRnPRnCaFArFYPMgArCaPBCaPBSiRnFYPBCaFArCaSiAl"

#start = "HOHOHO"


def possibles(input)
  possibilities = Set.new
  molecules = input.split /(?=[A-Z])/
  molecules.each_with_index do |mol, i|
    $repls[mol].each do |repl|
      if i == 0
        possibilities << ([repl] + molecules[(i+1..-1)]).join('')
      elsif i == molecules.length - 1
        possibilities << (molecules[(0..i-1)] + [repl]).join('')
      else
        possibilities << (molecules[(0..i-1)] + [repl] + molecules[(i+1..-1)]).join('')
      end
    end
  end
  possibilities
end

inputs = ['e']
i = 0
while true
  new_inputs = Set.new
  i += 1
  inputs.to_a.each do |input|
    puts "#{input}"
    ps = possibles(input)
    new_inputs = new_inputs + ps
    ps.each do |p|
      if p.length > start.length
        break
      end
      if p == start
        raise "got it at #{i}"
      end
    end
  end
  inputs = new_inputs
end
