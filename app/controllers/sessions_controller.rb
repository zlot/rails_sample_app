class SessionsController < ApplicationController

  def new
    
  end

  # auto-connected as REST verb due to resources :sessions in routes.rb
  def create
    
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user # friendly forwarding. see 9.19 http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#top
    else
      # flash.now is for displaying flash messages on rendered pages.
      # unlike flash, flash.now disappears as soon as there is an addit request.
      # see http://ruby.railstutorial.org/chapters/sign-in-sign-out#top Listing 8.12
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
    
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
