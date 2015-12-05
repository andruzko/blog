class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :favorites

  def to_param
    "#{id} #{name}".parameterize
  end

  has_secure_password
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :name, :email, :password, presence: true

  def rating
    count_post = self.posts.count
    count_comment = self.comments.count
    count_favorite = self.favorites.count

    count_post + count_comment + count_favorite
  end
end
