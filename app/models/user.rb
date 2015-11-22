class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :name, :email, :password, presence: true
end
