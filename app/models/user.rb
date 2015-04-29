class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password
  has_many :posts

  validates_presence_of :name, :email, :password
  validates_confirmation_of :password
  validates_uniqueness_of :email, case_sensitive: false

  def self.authenticate email, password
    user=find_by_email email
    if user && user.password_hash == BCrypt::Engine::hash_secret(password, user.password_salt)
      user
    end
  end

  def encrypt_password
    self.password_salt=BCrypt::Engine.generate_salt
    self.password_hash=BCrypt::Engine.hash_secret(password, password_salt)
  end

  def self.search query
    where "name like ? OR email like ?", "%#{query}%", "%#{query}%"
  end
end
