class Link < ActiveRecord::Base
  belongs_to :user

  validates :url,
    presence: true,
    url: true
  
  def check_if_read
    if self.read
      "read"
    else
      "unread"
    end
  end
end
