class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost destroyed!"
    redirect_to root_url
  end

  private

  def correct_user
    # @micropost = Micropost.find_by_id(params[:id])
    # redirect_to root_url unless current_user?(@micropost.user)
    # although it is better to run the code through an association this way
    @micropost = current_user.microposts.find(params[:id])
  rescue
    redirect_to root_url
  end


end