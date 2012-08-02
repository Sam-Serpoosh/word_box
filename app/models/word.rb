class Word < ActiveRecord::Base
  attr_accessible :vocabulary, :meaning

  belongs_to :user

  validates :vocabulary, :presence => true
  validates :meaning, :presence => true
end
