require 'spec_helper'

describe "StaticPages" do

  # let() creates a variable corresponding to its argument. 
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  

# OLD HOME PAGE TEST. Understandable but verbose. See below for better.
#describe "Home page" do
#  before { visit root_path }  # a before block. Visit root_path for the rest of the tests in this description.

#  it "should have the content 'Sample App'" do
#    expect(page).to have_content('Sample App')
#  end

#  it "should have the base title" do
#    expect(page).to have_title("Ruby on Rails Tutorial Sample App")
#  end

#  it "should not have a custom page title" do
#    expect(page).not_to have_title('| Home')
#  end
#end

# Home page test (better)
  
  subject { page } # tell RSpec that page is the subject of the tests.
                          # Capybara will make the call to should() automatically use the subject page.
  describe "Home page" do
    before { visit root_path }

    it { should have_content('Sample App') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  
  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end
