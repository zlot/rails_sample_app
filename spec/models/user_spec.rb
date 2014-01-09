require 'spec_helper'

describe User do

  before {
    @user = User.new(
      name: "Example User", 
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  }
  
  # SUBJECT 
  subject { @user }  # make @user the default subject of the test example
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:microposts) }
  
  
  
  
  it { should be_valid } # sanity check that @user is initially valid

  
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end


#-----------------------#
######### EMAIL #########

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
    
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format IS valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jb a+b@baz.cn]
      
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end
    it { should_not be_valid } # "it", i.e. the user. See the test above for the more verbose way of writing a test.
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
    
  end
  
  
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPlE.CoM" }
    
    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end
  
  
#-----------------------#
####### PASSWORDS #######

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }
    
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) } 
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      
      # "it (i.e. the user) should not equal user for invalid password"
      it { should_not eq user_for_invalid_password }
      # "specify: expect use for invalid password to be false"
      specify { expect(user_for_invalid_password).to be_false }
      #Note: specify is just a synonym for it, and can be used when writing it would sound unnatural.
   
    end
    
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank } # applies test to a given 
                                                 # attribute rather than the
                                                 # subject of the test.
                                                 # equiv to: it { expect(@user.remember_token).not_to be_blank }
                                                 
  end


end