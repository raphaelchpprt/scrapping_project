require_relative '../lib/dark_trader.rb'

describe "the perform method" do
  it "should return an array of hashes, and the array is not nil and there is no error" do
    expect(perform).not_to be_nil
  end
  it "should return a float > 0 for main keys"do
    expect(perform.first.values[0]).not_to be_nil
  end
end
