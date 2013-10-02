class StudioController < ApplicationController

  def show
    @user = User.find_by_username(params[:id])
    if @user.present?
      @studio = @user.studio
      @gear = @studio.gear
      @logged_in = @user == current_user
    else
      # go to an error page
      redirect_to root_url
    end
  end

  def explore
    @studios = Studio.paginate(:page => params[:page], :per_page => 20)
    @comments = Comment.order('created_at DESC').limit(10)
  end

end
