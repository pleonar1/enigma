require "./lib/alphabet"
require "date"

class Enigma
  attr_reader :alphabet_hash,
              :alphabet_array,
              :encrypted_hash,
              :decrypted_hash

  def initialize
    @alphabet_hash  = Alphabet.new.index
    @alphabet_array = Alphabet.new.alphabet_array
    @encrypted_hash = {encryption: nil,
                       key: nil,
                       date: nil}
    @decrypted_hash = {decryption: nil,
                       key: nil,
                       date: nil}
  end

  def generate_key
    rand(99999).to_s.rjust(5, '0')
  end

  def format_date(new_date)#change name
    squared_date = new_date.to_i ** 2
    squared_date.to_s.slice(-4..-1)
  end

  def generate_date
    date = Date.today
    date_to_string = date.strftime('%d%m%y')
  end

  def shift(key, date, encrypt = true)
    a_offset = key.slice(0..1).to_i + date.slice(0).to_i
    b_offset = key.slice(1..2).to_i + date.slice(1).to_i
    c_offset = key.slice(2..3).to_i + date.slice(2).to_i
    d_offset = key.slice(3..4).to_i + date.slice(3).to_i
    shifts = [a_offset, b_offset, c_offset, d_offset]
    if encrypt
      return shifts
    else
      return shifts.map{|shift| shift * -1}
    end
  end

  def number_generator(message)
    message_array = message.chars
    message_array.map do |letter|
      @alphabet_hash[letter]
    end
  end

  def encrypt(message, key = generate_key, date = generate_date)
    shift = shift(key, format_date(date))
    message_array = number_generator(message.gsub(/\n/, ""))
    encrypted_message = message_array.map.with_index do |letter, index| #this below if statement could be refactored into a helper m
      @alphabet_array.rotate(shift[index % 4])[letter]
    end
    @encrypted_hash[:encryption] = encrypted_message.join
    @encrypted_hash[:key]        = key
    @encrypted_hash[:date]       = date
    @encrypted_hash
  end

  def decrypt(message, key, date = generate_date)
    shift = shift(key, format_date(date), false)
    message_array = number_generator(message.gsub(/\n/, ""))
    collector = []
    message_array.each_with_index do |letter, index|
      collector << @alphabet_array.rotate(shift[index % 4])[letter]
    end
    @decrypted_hash[:decryption] = collector.join
    @decrypted_hash[:key]        = key
    @decrypted_hash[:date]       = date
    @decrypted_hash
  end
end
