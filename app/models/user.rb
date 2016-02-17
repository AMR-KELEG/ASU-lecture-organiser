class User < ActiveRecord::Base
  has_secure_password
  validates :firstname , presence: true
  validates :surname , presence: true
  validates :username, uniqueness: true,presence: true
  validates :password, confirmation: true, length: { minimum: 8 }
end
