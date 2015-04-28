class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :comments

  validates_presence_of :title, :category, :user, :image, :body
  validates_length_of :title, minimum: 5
  validates_length_of :body, minimum: 25
end
