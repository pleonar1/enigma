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
    expect(@enigma.generate_keys).to be_a String
    expect(@enigma.generate_keys.length).to eq 5
  end

  it "can generate the date" do
    expect(@enigma.generate_date).to be_a String
    expect(@enigma.generate_date.length).to be 4
  end

  it "can shift" do
    expect(@enigma.shift("02715", "1025")).to eq([3, 27, 73, 20])
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
end
