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

  it "has an alphabet" do
    expect(@enigma.alphabet).to be_a Hash
    expect(@enigma.alphabet.count).to eq 27
  end

  it "can generate keys" do
    expect(@enigma.generate_keys).to be_a String
    expect(@enigma.generate_keys.length).to eq 5
  end

  it "can generate the date" do
    expect(@enigma.generate_date).to be_a String
    expect(@enigma.generate_date.length).to be 4
  end
end
