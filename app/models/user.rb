class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  
  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug_to_find)
    User.all.find do |user|
      user.slug = slug_to_find
    end
  end
end
