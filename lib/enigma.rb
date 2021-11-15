require "./alphabet"
require "date"


class Enigma
  attr_reader :alphabet

  def initialize
    @alphabet = Alphabet.new.index
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
end
