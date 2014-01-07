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
  # default route: /users/{id} HTTPrequest: POST
  def create
    @user = User.new(user_params) # call user_params(), see private method
    if @user.save
      sign_in @user       # sign the user in
      flash[:success] = "Welcome to the Sample App!" # flash is defined in 
                                                     #  application.html.erb
      redirect_to @user   # redirect
    else
      render 'new'        # render the new action.
    end
  end
  
  # REST-supported action, tied to resources :users in routes.rb
  # default route: /users/{id}/edit HTTPrequest: GET
  def edit
    @user = User.find(params[:id])
  end
  
  # REST-supported action, tied to resources :users in routes.rb.
  # default route: /users/{id} HTTPrequest: PATCH
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params())
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
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
