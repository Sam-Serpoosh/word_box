require 'spec_helper'

describe Word do
  context "#validation" do
    it "is not valid without vocabulary" do
      Word.new.should_not be_valid
    end

    it "is not valid without meaning" do
      word = Word.new(:vocabulary => "hello")
      word.should_not be_valid
    end
  end
end
