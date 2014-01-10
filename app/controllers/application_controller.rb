class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Include Sessions helper functions in ALL controllers.
  #  by default, all the helpers are available in the views but NOT the controllers.
  include SessionsHelper
end
