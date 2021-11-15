require_relative 'spec_helper'
require "./lib/enigma"
require "./lib/alphabet"

RSpec.describe "enigma" do
  before(:each) do
    @enigma = Enigma.new

  end

  it "exists" do
    expect(@enigma).to be_a Enigma
  end

  it "has an alphabet in a hash and an array" do
    expect(@enigma.alphabet_hash).to be_a Hash
    expect(@enigma.alphabet_hash.count).to eq 27
    expect(@enigma.alphabet_array).to be_a Array
    expect(@enigma.alphabet_array.count).to eq 27
  end

  it "can generate keys" do
    expect(@enigma.generate_key).to be_a String
    expect(@enigma.generate_key.length).to eq 5
  end

  it "can generate the date" do
    expect(@enigma.generate_date).to be_a String
    expect(@enigma.generate_date.length).to be 6
  end

  it "can shift for encryption" do
    expect(@enigma.encrypt_shift("02715", "1025")).to eq([3, 27, 73, 20])
  end

  it "can shift for decryption" do
    expect(@enigma.decrypt_shift("02715", "1025")).to eq([-3, -27, -73, -20])
  end

  it "can turn the message into an array of numbers" do
    expect(@enigma.number_generator("hello world")).to be_a Array
    expect(@enigma.number_generator("hello world")).to eq([7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3])
  end

  it "can format the date" do
    expect(@enigma.format_date("040895")).to eq("1025")
    expect(@enigma.format_date("040895")).to be_a String
  end

  it "can encrypt" do
    expect(@enigma.encrypt("hello world", "02715", "040895")).to eq( {
                                                                      encryption: "keder ohulw",
                                                                      key: "02715",
                                                                      date: "040895"
                                                                      })
  end

  it "can decrypt" do
    expect(@enigma.decrypt("keder ohulw", "02715", "040895")).to eq( {
                                                                      decryption: "hello world",
                                                                      key: "02715",
                                                                      date: "040895"
                                                                      })
  end

  it "can encrypt a message with a key and todays date
      and can decrypt it back" do
    encrypted = @enigma.encrypt("hello world", "02715")
    expect(encrypted[:encryption]).to be_a String
    expect(encrypted[:encryption].length).to eq(11)
    expect(encrypted[:date]).to be_a String
    expect(encrypted[:date].length).to eq(6)
    expect(encrypted[:key]).to eq("02715")
    expect(@enigma.decrypt(encrypted[:encryption], "02715")).to eq({:date=>"151121",
                                                                    :decryption=>"hello world",
                                                                    :key=>"02715"})
  end

  it "can encrypt a message by generating a random
      key and todays date" do
    encrypted = @enigma.encrypt("hello world")
    expect(encrypted).to be_a Hash
    expect(encrypted.keys.count).to eq 3
  end
end
