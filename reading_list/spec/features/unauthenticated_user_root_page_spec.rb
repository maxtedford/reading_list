require 'rails_helper'

RSpec.describe "user", type: :feature do
  context "visits the root page" do
    
    before(:each) { visit root_path }
    
    it "sees the welcome page" do
      expect(page).to have_content("Welcome to reading list!")
    end

    it "sees a sign-up link on the root page" do
      expect(page).to have_link("Sign Up")
    end
    
    it "sees a login link on the root page" do
      expect(page).to have_link("Login")
    end
    
    it "redirects to the user account creation page when sign up link clicked" do
      click_link "Sign Up"
      
      expect(page).to have_field("user[email]")
      expect(page).to have_field("user[password]")
      expect(page).to have_field("user[password_confirmation]")
    end
    
    it "creates the user's account and redirects them to their reading list" do
      click_link "Sign Up"
      fill_in "user[email]", with: "max@max.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_button "Sign Up"
      
      expect(page).to have_content("Welcome to Reading List, max@max.com!")
    end
    
    it "adds a new user to the database upon sign up" do
      expect(User.count).to eq(0)
      
      click_link "Sign Up"
      fill_in "user[email]", with: "max@max.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_button "Sign Up"

      expect(User.count).to eq(1)
    end
    
    it "redirects the user to the login page upon clicking login link" do
      click_link "Login"

      expect(page).to have_field("session[email]")
      expect(page).to have_field("session[password]")
    end
    
    it "logs a user in and redirects him/her to his/her show page with all links" do
      User.create(email: "max@max.com",
                  password: "password")
      
      click_link "Login"
      fill_in "session[email]", with: "max@max.com"
      fill_in "session[password]", with: "password"
      click_button "Login"
      
      expect(current_path).not_to eq(login_path)
      expect(page).to have_content("Welcome to Reading List, max@max.com!")
    end
  end
end
