class ShotsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @game = Game.find(params[:game_id])
    @shots = @game.shots.order("round asc")
  end

  def show
    @shot = Shot.find(params[:id])
  end

  def new
    @game = Game.find(params[:game_id])
    @shots = []
    6.times { |i| @shots << @game.shots.build(:player_id => i) }
  end

  def edit
    @shot = Shot.find(params[:id])
  end

  def create
    @game = Game.find(params[:game_id])
    @shot = @game.shots.new(params[:shot])

    if @shot.save
      redirect_to(game_shots_path(@game), :notice => 'Shot was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @shot = Shot.find(params[:id])

      if @shot.update_attributes(params[:shot])
        redirect_to(@shot, :notice => 'Shot was successfully updated.')
      else
        render :action => "edit"
      end
  end

  def destroy
    @shot = Shot.find(params[:id])
    @shot.destroy

     redirect_to(shots_url)
  end
end
