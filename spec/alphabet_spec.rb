require_relative 'spec_helper'
require './lib/alphabet'

RSpec.describe "alphabet" do
  before(:each) do
    @alphabet = Alphabet.new
  end

  it "exists" do
    expect(@alphabet).to be_a Alphabet
  end

  it "has attributes" do
    expect(@alphabet.index).to be_a Hash
    expect(@alphabet.index.count).to eq 27
    end
end
