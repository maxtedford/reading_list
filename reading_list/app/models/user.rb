class User < ActiveRecord::Base
  has_many :links
  has_secure_password
  
  validates :email,
    presence: true,
    uniqueness: true,
    format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :password_digest,
    confirmation: true
  
  def read_links
    links.where(read: true)
  end
  
  def unread_links
    links.where(read: false) && links.where(read: nil)
  end
end
