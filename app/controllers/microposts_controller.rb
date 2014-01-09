class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]   # can be found in app/controllers/helps/sessions_helper.rb 
  before_action :correct_user,   only: :destroy
  
  def create
    
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []  # adding an empty @feed_items in case of a failed micropost creation
      render 'static_pages/home'
    end
    
  end
  
  def destroy
    @micropost.destroy    # note: it gets @micropost via before_action, see top of this class.
    redirect_to root_url
  end
  
  private
  
    # using strong parameters. See Listing 10.27 http://ruby.railstutorial.org/chapters/user-microposts#top
    def micropost_params
      params.require(:micropost).permit(:content)
    end
  
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
  
end