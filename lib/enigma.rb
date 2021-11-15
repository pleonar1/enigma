require "./alphabet"


class Enigma
  attr_reader :alphabet

  def initialize
    @alphabet = Alphabet.new.index
  end
end
