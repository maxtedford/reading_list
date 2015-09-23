require 'rails_helper'

RSpec.describe "authenticated user", type: :feature do
  context "logs in" do
    
    let(:user) { User.create(email: "max@max.com",
                             password: "password")}
    
    it "displays a logout button on the user's homepage" do
      user
      visit root_path
      click_link "Login"
      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password
      click_button "Login"
      
      expect(page).to have_link("Logout")
    end
  end
  
  context "on the links page" do

    let(:user) { User.create(email: "max@max.com",
                             password: "password")}
    
    before(:each) do
      user
      visit root_path
      click_link "Login"
      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password
      click_button "Login"
    end
    
    it "can see a form to submit a new link" do
      expect(page).to have_field("link[url]")
      expect(page).to have_button("Add")
    end
    
    it "adds a new link for the user upon submission" do
      expect(user.links.count).to eq(0)
      
      fill_in "link[url]", with: "http://examplelink.com"
      click_button "Add"
      
      expect(page).to have_content("http://examplelink.com")
      expect(user.links.count).to eq(1)
    end
    
    it "displays all the links as actual clickable links" do
      fill_in "link[url]", with: "http://examplelink.com"
      click_button "Add"
      
      expect(page).to have_link("http://examplelink.com")
    end
  end
end
