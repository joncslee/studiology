class StudioController < ApplicationController

  def show
    @user = User.find_by_username(params[:id])
    @studio = @user.studio
    @logged_in = @user == current_user
  end

end
