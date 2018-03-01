class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    respond_to do |format|
      if @micropost.save
        format.html { redirect_to root_url, success: "Post was successfully created!" }
        format.js
      else
        format.html { render 'static_pages/home' }
        format.js
      end
    end
    	# if @micropost.save
     #  		flash[:success] = "Micropost created!"
     #  		redirect_to root_url  
    	# else
    	# 	@feed_items = []
     #  		render 'static_pages/home'
    	# end
  end

    def destroy
      respond_to do |format|
        if @micropost.destroy
          format.html {redirect_to request.referrer || root_url, notice: "Micropost deleted"}
          format.js
        else
          format.html {render 'new'}
          format.js
        end
      end
      
    end

    private
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
  end
