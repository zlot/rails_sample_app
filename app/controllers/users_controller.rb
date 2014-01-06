class UsersController < ApplicationController
  
  # resources :users in config/routes.rb maps this def to REST.
  # see Table 7.1 at: http://ruby.railstutorial.org/chapters/sign-up#top 
  def show
    @user = User.find(params[:id]) # gives @user instance var access to the 
                                   # show.html.erb view.
                                   # params retrieves the user id eg /users/1
  end
  
  def new
    @user = User.new
  end
  
  # REST-supported action, tied to resources :users in routes.rb.
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!" # flash is defined in 
                                                     #  application.html.erb
      redirect_to @user   # redirect
    else
      render 'new'        # render the new action.
    end
  end
  
  
  private
  
    # safe way of taking a POST request from a user and filtering their submitted
    # data so we only accept the parameters we want!
    # these are called strong parameters.  
    def user_params
      params.require(:user).permit(
            :name, :email, :password, :password_confirmation)
    end
  
end
