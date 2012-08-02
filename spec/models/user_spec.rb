require 'spec_helper'

describe User do
  context "#validation" do
    before do
      @attr = { :name => "sam", :email => "sam@example.com",
                :password => "password", :password_confirmation => "password" }
    end
    it "is not valid without name" do
      user = User.new
      user.should_not be_valid
    end

    it "is not valid without email" do
      user = User.new(@attr.merge!(:email => ""))
      user.should_not be_valid 
    end

    it "is not valid with already existed email" do
      email = "sam@example.com"
      user = User.create!(@attr.merge!(:email => email))
      other_user = User.new(@attr.merge!(:email => email))
      other_user.should_not be_valid
    end

    it "is not valid with wrong email format" do
      user = User.new(@attr.merge!(:email => ".com"))
      user.should_not be_valid
    end

    it "is not valid without password" do
      user = User.new(@attr.merge!(:password => ""))
      user.should_not be_valid
    end

    it "is not valid without password confirmation" do
      user = User.new(@attr.merge!(:password_confirmation => ""))
      user.should_not be_valid
    end
  end

  context "#word_association" do
    it "associates with words" do
      user = FactoryGirl.create(:user)
      word = FactoryGirl.create(:word, :user => user)
      user.words.should == [word]
    end

    it "builds word through the association" do
      user = FactoryGirl.create(:user)
      user.words.create!(:vocabulary => "hello", :meaning => "salam")
      user.words.count.should == 1
      user.words.first.vocabulary.should == "hello"
    end
  end
end
