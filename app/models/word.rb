class Word < ActiveRecord::Base
  attr_accessible :vocabulary, :meaning

  validates :vocabulary, :presence => true
  validates :meaning, :presence => true
end
