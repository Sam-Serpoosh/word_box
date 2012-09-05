class Word < ActiveRecord::Base
  attr_accessible :vocabulary, :meaning

  belongs_to :user

  validates :vocabulary, :presence => true
  validates :meaning, :presence => true

  def self.today
    where("created_at > ?", 1.day.ago)
  end
end
