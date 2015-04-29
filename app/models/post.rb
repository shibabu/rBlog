class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :comments
  has_attached_file :image, default_url: 'Rails_small.jpg'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates_presence_of :title, :category, :user, :body
  validates_length_of :title, minimum: 5
  validates_length_of :body, minimum: 25

  def self.search query
    where "title like ? OR body like ?", "%#{query}%", "%#{query}%"
  end
end
