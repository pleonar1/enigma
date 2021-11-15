require "./enigma"


enigma     = Enigma.new
message    = ARGV[0]
encryption = ARGV[1]

file = File.new(message).read

File.open(encryption, "w") do |file|
  enigma.encrypt(file)
  file.puts en
