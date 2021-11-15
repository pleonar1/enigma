require "./alphabet"
require "date"


class Enigma
  attr_reader :alphabet_hash, :alphabet_array

  def initialize
    @alphabet_hash  = Alphabet.new.index
    @alphabet_array = ("a".."z").to_a << " "
  end

  def generate_keys
    rand(99999).to_s.rjust(5, '0')
  end

  def generate_date
    date = Date.today
    date_to_string = date.strftime('%d-%m-%Y')
    date_no_dashes = date_to_string.delete('-').chars
    date_no_dashes.delete_at(4)
    date_no_dashes.delete_at(4)
    final_date = (date_no_dashes.join.to_i) ** 2
    final_date_code = final_date.to_s.slice(-4..-1)
  end

  def shift(key, date)
    a_offset = key.slice(0..1).to_i + date.slice(0).to_i
    b_offset = key.slice(1..2).to_i + date.slice(1).to_i
    c_offset = key.slice(2..3).to_i + date.slice(2).to_i
    d_offset = key.slice(3..4).to_i + date.slice(3).to_i
    [a_offset, b_offset, c_offset, d_offset]
  end

  def number_generator
    
  end

  def encrypt(message, key = generate_key , date = generate_date)
    shift = shift(key, date)
    message_array = message.chars
    collector = []
    message_array.each_with_index do |letter, index|
      if index % 4 == 0
        require "pry"; binding.pry
        collector << @alphabet_array.rotate(shift[0])[letter.to_i]

      elsif index % 4 == 1
        collector << @alphabet_array.rotate(shift[1])[index]
      elsif index % 4 == 2
        collector << @alphabet_array.rotate(shift[2])[index]
      elsif index % 4 == 3
        collector << @alphabet_array.rotate(shift[3])[index]
      end
    end
    require "pry"; binding.pry
  end
end
