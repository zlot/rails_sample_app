module SessionsHelper
  
  def sign_in(user)
    # create a new token
    remember_token = User.new_remember_token
    
    # place unencrypted token in browser cookies. # cookies utility supplied by Rails.
    cookies.permanent[:remember_token] = remember_token
    
    # encrypt and save token into database
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    
    # set current user equal to given user
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  # Ruby special syntax for defining an ASSIGNMENT FUNCTION
  # This defines a method current_user=, which is designed to handle assignment
  #  to current_user. i.e. self.current_user = (...) is auto-converted to 
  #    current_user=(...), invoking the current_user= method.
  # This is necessary for remembering the user from page to page! THIS IS DIFFERENT
  #   TO THE FUNCTIONALITY OF attr_accessor.
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    # encrypt the token from the cookie before using it to find the user in the db.
    remember_token = User.encrypt(cookies[:remember_token])
    
    @current_user ||= User.find_by(remember_token: remember_token) # ||= means "or equals".
      # The effect of ||= is to set the @current_user ivar to the user corresponding
      #   to the remember token, but only if @current_user is undefined.
      #   aka it will call the find_by method the first time current_user is called,
      #   but on subsequent invocations returns @current_user without hitting the db.
  end
  
  
  def sign_out
    current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
end
