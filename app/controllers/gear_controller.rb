class GearController < ApplicationController

  before_filter :authenticate_user!, :except => [:search_suggestions, :add_gear, :show]

  def index
    @gear = Gear.all.sample(50)
  end

  def show
    @gear = Gear.friendly.find(params[:id])
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
    @user = current_user
    @gear = @user.studio.gear
  end

  def popular
    @microphones = Gear.popular_by_category('Microphones')
    @interfaces = Gear.popular_by_category('Audio Interfaces')
    @midi = Gear.popular_by_category('Keyboards/MIDI')
  end

  #
  # actions to take place on the gear selection page
  #
  def search_suggestions
    @search = Gear.search do
      fulltext params[:search]
    end

    @gear = @search.results

    respond_to do |format|
      format.js
    end
  end

  def update_gear
    add_or_delete = params[:aod]
    if user_signed_in?
      if add_or_delete == 'add'
        current_user.studio.add_gear params[:gear_id]
      else
        current_user.studio.delete_gear params[:gear_id]
      end
    end

    @gear = current_user.studio.gear

    respond_to do |format|
      format.js
    end
  end

end
