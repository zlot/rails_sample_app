class UsersController < ApplicationController
  
  # this is a before filter. This allows particular methods to be called before
  #   any given actions. To require users to be signed in, we define a sign_in_user
  #   method and invoke it here. See Listing 9.12
  #   http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#top
  #   using the :only options hash, we say this applies only to the edit() and update() methods.
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  # protected from non-signed-in users via the before_action :correct_user.
  def index
    @users = User.paginate(page: params[:page]) # :page is generated automatically by will_paginate. See Listing 9.34 
  end
  
  # resources :users in config/routes.rb maps this def to REST.
  # see Table 7.1 at: http://ruby.railstutorial.org/chapters/sign-up#top 
  def show
    @user = User.find(params[:id]) # gives @user instance var access to the 
                                   # show.html.erb view.
                                   # params retrieves the user id eg /users/1
    @microposts = @user.microposts.paginate(page: params[:page])
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
    # protected via the before_action :correct_user.
  end
  
  # REST-supported action, tied to resources :users in routes.rb.
  # default route: /users/{id} HTTPrequest: PATCH
  def update
    if @user.update_attributes(user_params())
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  private
  
    # safe way of taking a POST request from a user and filtering their submitted
    # data so we only accept the parameters we want!
    # these are called strong parameters.  
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end
  
  
  ### Before filters
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
