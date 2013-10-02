class CommentsController < ApplicationController

  def create
    if params[:commentable_type] == 'Gear'
      @commentable = Gear.friendly.find(params[:commentable_id])
    elsif params[:commentable_type] == 'Studio'
      @commentable = Studio.find(params[:commentable_id])
    end
    @comment = Comment.build_from(@commentable, current_user.id, params['body'])

    if @comment.save!
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @gear = Gear.find(params[:id])
    @gear.destroy
    redirect_to gear_url, :notice => "Successfully destroyed gear."
  end


end
