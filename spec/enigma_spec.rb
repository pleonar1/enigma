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
end
