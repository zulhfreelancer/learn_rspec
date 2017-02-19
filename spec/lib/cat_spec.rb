require "rails_helper"

describe Cat do
  before :each do
    @cat = build(:cat)
  end

  it "has a name" do
  	expect(@cat.name).not_to be_nil
  end

  it "has a name in string format" do
  	expect(@cat.name).to be_a(String)
  end

  it "has an age" do
  	expect(@cat.age).not_to be_nil
  end

  it "has an age in fixnum format" do
  	expect(@cat.age).to be_a(Fixnum)
  end

  it "has a description" do
  	expect(@cat.describe).not_to be_nil
  end

  it "has a correct description copy" do
  	expect(@cat.describe).to eq("Oreo is 3 years old.")
  end
end
