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

  def format_date(new_date)
    squared_date = new_date.to_i ** 2
    squared_date.to_s.slice(-4..-1)
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

  def number_generator(message)
    message_array = message.chars
    message_array.map do |letter|
      @alphabet_hash[letter]
    end
  end

  def encrypt(message, key = generate_key , date = generate_date)
    shift = shift(key, format_date(date))
    message_array = number_generator(message)
    collector = []
    encrypted_hash = Hash.new
    message_array.each_with_index do |letter, index|
      if index % 4 == 0
        collector << @alphabet_array.rotate(shift[0])[letter]
      elsif index % 4 == 1
        collector << @alphabet_array.rotate(shift[1])[letter]
      elsif index % 4 == 2
        collector << @alphabet_array.rotate(shift[2])[letter]
      elsif index % 4 == 3
        collector << @alphabet_array.rotate(shift[3])[letter]
      end
    end
    encrypted_hash[:encryption] = collector.join
    encrypted_hash[:key]       = key
    encrypted_hash[:date]      = date
    encrypted_hash
  end

  def decrypt(message, key = generate_key , date = generate_date)
    shift = shift(key, format_date(date))
    message_array = number_generator(message)
    collector = []
    encrypted_hash = Hash.new
    message_array.each_with_index do |letter, index|
      if index % 4 == 0
        collector << @alphabet_array.rotate(shift[0])[letter]
      elsif index % 4 == 1
        collector << @alphabet_array.rotate(shift[1])[letter]
      elsif index % 4 == 2
        collector << @alphabet_array.rotate(shift[2])[letter]
      elsif index % 4 == 3
        collector << @alphabet_array.rotate(shift[3])[letter]
      end
    end
    encrypted_hash[:encryption] = collector.join
    encrypted_hash[:key]       = key
    encrypted_hash[:date]      = date
    encrypted_hash
    require "pry"; binding.pry
  end
end
