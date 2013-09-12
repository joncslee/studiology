class GearController < ApplicationController

  before_filter :authenticate_user!

  def index
    @gear = Gear.all.sample(50)
  end

  def show
    @gear = Gear.find(params[:id])
  end

  def new
    @gear = Gear.new
  end

  def create
    @gear = Gear.new(params[:gear])
    if @gear.save
      redirect_to @gear, :notice => "Successfully created gear."
    else
      render :action => 'new'
    end
  end

  def edit
    @gear = Gear.find(params[:id])
  end

  def update
    @gear = Gear.find(params[:id])
    if @gear.update_attributes(params[:gear])
      redirect_to @gear, :notice  => "Successfully updated gear."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @gear = Gear.find(params[:id])
    @gear.destroy
    redirect_to gear_url, :notice => "Successfully destroyed gear."
  end

  def upload
  end

  #
  # actions to take place on the gear selection page
  #
  def search_suggestions
    @gear = Gear.where("name LIKE ?", "%#{params[:search]}%").limit(20).order('popular DESC')

    respond_to do |format|
      format.js
    end
  end

  def add_gear
    if user_signed_in?
      current_user.studio.add_gear params[:gear_id]
    end

    @gear = current_user.studio.gear

    respond_to do |format|
      format.js
    end
  end
end
