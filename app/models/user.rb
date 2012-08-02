class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :words

  email_regex = /([a-zA-Z.]+(\d)*)+\@[a-zA-Z]+\.[a-zA-Z]+/i

  validates :name, :presence => true
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }  
  validates :password, :presence => true,
                       :confirmation => true
end
