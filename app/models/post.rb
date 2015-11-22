class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :tags, through: :post_tags
  has_many :post_tags

  validates :title, :body, presence: true
  validates :title, uniqueness: true
  validates :title, length: { in: 5..140 }
  validates :body, length: { minimum: 140 }
  serialize :rater, Array

  scope :newest, ->{order("created_at DESC")}

  def self.search(query)
  # where(:title, query) -> This would return an exact match of the query
   where("title like ? or body like ?", "%#{query}%", "%#{query}%")
  end
end
