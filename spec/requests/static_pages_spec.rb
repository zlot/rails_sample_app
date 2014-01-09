require 'spec_helper'

describe "StaticPages" do

  # let() creates a variable corresponding to its argument. 
#  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  

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
  
#  subject { page } # tell RSpec that page is the subject of the tests.
#                          # Capybara will make the call to should() automatically use the subject page.
#  describe "Home page" do
#    before { visit root_path }

#    it { should have_content('Sample App') }
#    it { should have_title(full_title('')) }
#    it { should_not have_title('| Home') }
#  end

# MOST ADVANCED, using RSpec shared example, to elimiate test duplication:  
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"    # shared_examples use
    it { should_not have_title('| Home') }
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
    
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)   { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
    it {should have_title(full_title(page_title)) }
  end

 # describe "About page" do
    before { visit about_path }
    let(:heading)   { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
    it {should have_title(full_title(page_title)) }
 # end

 # describe "Contact page" do
    before { visit contact_path }
    let(:heading)   { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
    it {should have_title(full_title(page_title)) }
  #end


  # TEST for links on the layout.
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "sample app"
    expect(page).to have_title(full_title(''))
  end  

end
