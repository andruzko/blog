class Post < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites

  validates :title, :body, presence: true
  validates :title, uniqueness: true
  validates :title, length: { in: 5..140 }
  validates :body, length: { minimum: 140 }
  serialize :rater, Array


  scope :newest, ->{order("created_at DESC")}

  def self.search(query)
   where("title like ? or body like ?", "%#{query}%", "%#{query}%")
  end

end
