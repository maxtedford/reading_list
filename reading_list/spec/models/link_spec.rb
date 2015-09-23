require 'rails_helper'

RSpec.describe Link, type: :model do
  context "upon creation" do
    
    let(:valid_attributes) { { url: "http://examplelink.com",
                               read: false } }
    
    it "is valid" do
      link = Link.create(valid_attributes)
      
      expect(link).to be_valid
    end
    
    it "is invalid without a url" do
      link = Link.create(read: false)
      
      expect(link).not_to be_valid
    end
    
    it "defaults to a read status of false" do
      link = Link.create(url: "http://examplelink.com")
      
      expect(link.read).to be_falsey
    end
    
    it "will only accept a valid url" do
      valid_link = Link.create(valid_attributes)
      invalid_link = Link.create(url: "blahblah")
      
      expect(valid_link).to be_valid
      expect(invalid_link).not_to be_valid
    end
  end
  
  context "relationships" do
    
    let(:valid_attributes) { { url: "http://examplelink.com" } }
    
    it "responds to user" do
      link = Link.create(valid_attributes)
      
      expect(link).to respond_to(:user)
    end
  end
end
