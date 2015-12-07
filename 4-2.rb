require 'digest/md5'

INPUT = "iwrupvqb"
i = 0

while true
  puts i if i % 1000 == 0
  to_hash = "#{INPUT}#{i}"
  hash = Digest::MD5.hexdigest(to_hash)
  if hash.start_with? '00000'
    puts i
    break
  end
  i += 1
end
