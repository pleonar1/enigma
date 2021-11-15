require './lib/enigma'
require './lib/alphabet'

enigma = Enigma.new

encryption = ARGV[0]
decryption = ARGV[1]
key        = ARGV[2]
date       = ARGV[3]

encrypted_file = File.new(encryption).read
File.open(decryption, "w") do |file|
  enigma.decrypt(encrypted_file, key, date)
  file.puts enigma.decrypted_hash[:decryption]
  puts "Created #{decryption} with the key #{key} and date #{date}"
end
