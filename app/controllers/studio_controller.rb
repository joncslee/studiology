class StudioController < ApplicationController

  def show
    @user = User.find_by_username(params[:id])
    if @user.present?
      @studio = @user.studio
      @logged_in = @user == current_user
    else
      # go to an error page
      redirect_to root_url
    end
  end

  def explore
    @studios = Studio.all
  end

end
