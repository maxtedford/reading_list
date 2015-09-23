require 'rails_helper'

RSpec.describe User, type: :model do
  context "when being created" do
    
    let(:valid_attributes) { { email: "max@max.com",
                               password: "password" } }
    
    it "is valid" do
      user = User.create(valid_attributes)
      
      expect(user).to be_valid
    end
    
    it "is invalid without an email" do
      user = User.create( password: "password" )
      
      expect(user).not_to be_valid
    end
    
    it "is invalid unless unique" do
      valid_user = User.create(valid_attributes)
      invalid_user = User.create(email: "max@max.com",
                                 password: "password2")
      
      expect(invalid_user).not_to be_valid
    end
    
    it "must have a valid email format" do
      valid_user = User.create(valid_attributes)
      invalid_user = User.create(email: "abcdefg",
                         password: "password")
      
      expect(valid_user).to be_valid
      expect(invalid_user).not_to be_valid
    end
  end
  
  context "relationships" do

    let(:valid_attributes) { { email: "max@max.com",
                               password: "password" } }
    
    it "has links" do
      user = User.create(valid_attributes)
      
      expect(user).to respond_to(:links)
    end
  end
  
  context "read or unread links" do
    
    let(:valid_attributes) { { email: "max@max.com",
                               password: "password" } }
    
    it "can return all the read links" do
      user = User.create(valid_attributes)
      user.links.create(url: "http://unreadlink.com",
                        read: false)
      user.links.create(url: "http://readlink.com",
                        read: true)
      
      expect(user.read_links.first.url).to eq("http://readlink.com")
      expect(user.read_links.count).to eq(1)
    end

    it "can return all the unread links" do
      user = User.create(valid_attributes)
      user.links.create(url: "http://unreadlink.com",
        read: false)
      user.links.create(url: "http://readlink.com",
        read: true)

      expect(user.read_links.first.url).to eq("http://readlink.com")
      expect(user.read_links.count).to eq(1)
    end
  end
end
