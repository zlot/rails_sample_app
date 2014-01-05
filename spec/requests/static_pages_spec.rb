require 'spec_helper'

describe "StaticPages" do

  # let() creates a variable corresponding to its argument. 
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App') # simply look for the string 'Sample App'
    end
    
    it "should have the right title" do
      visit '/static_pages/home'
      expect(page).to have_title("#{base_title} | Home") #checks for an HTML title with the given content.
      # note that a substring would work as well: have_title("Home")
    end
    
  end
  
  describe "Help page" do
    it"should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    
    it "should have the right title" do
      visit '/static_pages/help'
      expect(page).to have_title("#{base_title} | Help")
    end
  end
  
  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end
    
    it "should have the right title" do
      visit '/static_pages/about'
      expect(page).to have_title("#{base_title} | About Us")
    end    
  end
  
  
end
