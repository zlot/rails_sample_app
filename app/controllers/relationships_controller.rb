class RelationshipsController < ApplicationController
  
  before_action :signed_in_user # Found in sessions_helper.rb.
                                # How does this controlelr have access to sessions_helper.rb?
                                #   see application_controller.rb.
  
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    
    # deal with the response format
    respond_to do |format|
      format.html { redirect_to @user } # if plain html, simply redirect.
       
      # NOTE:: THIS ISNT WORKING CORRECTLY!
      #   see http://techthereq.tumblr.com/post/18910961502/rails-3-using-form-remote-true-with-jquery-ujs
      # note: no passed options here auto-route to create.js.erb, like using :template as below in def destroy
      format.js   {}                     # if using ajax, go to create.js.erb (see Listing 11.38 http://ruby.railstutorial.org/chapters/following-users#sec-the_relationship_model)
    end
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
      current_user.unfollow!(@user)
      
    # deal with the response format
    respond_to do |format|
      format.html { redirect_to @user } # if plain html, simply redirect. 
      
      # NOTE:: THIS ISNT WORKING CORRECTLY!
      # but it SHOULD BE: see http://techthereq.tumblr.com/post/18910961502/rails-3-using-form-remote-true-with-jquery-ujs
      format.js do
        render :template => 'relationships/destroy.js.erb'                      # if using ajax, go to destroy.js.erb (see Listing 11.38 http://ruby.railstutorial.org/chapters/following-users#sec-the_relationship_model)
      end
    end
  end
  
  
end