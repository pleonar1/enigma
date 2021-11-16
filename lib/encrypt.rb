require './lib/enigma'
require './lib/alphabet'



enigma     = Enigma.new
message    = ARGV[0]
encryption = ARGV[1]
key        = ARGV[2]
date       = ARGV[3]


mes_file = File.new(message).read

File.open(encryption, "w") do |file|
  enigma.encrypt(mes_file, key, date)
  file.puts enigma.encrypted_hash[:encryption]
  puts "Created #{encryption} with the key #{key} and date #{date}"
end
