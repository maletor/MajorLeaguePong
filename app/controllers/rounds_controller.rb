class RoundsController < ApplicationController
  
  def index
    @game = Game.find(params[:game_id])
    @rounds = @game.rounds
  end

  def show
    @round = Round.find(params[:id])
  end

  def new
    @game = Game.find(params[:game_id])
    @round = @game.rounds.build

    6.times { @round.shots.build }
  end

  def edit
    @game = Game.find(params[:game_id])
    @round = Round.find(params[:id])
  end

  def create
    @game = Game.find(params[:game_id])
    @round = @game.rounds.create(params[:round])

    if @round.save
      redirect_to(game_rounds_path(@game), :notice => 'Round was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @round = Round.find(params[:id])

    if @round.update_attributes(params[:round])
      redirect_to(@round, :notice => 'Round was successfully updated.')
    else
      render :action => "edit" 
    end
  end

  def destroy
    @round = Round.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to(rounds_url) }
      format.xml  { head :ok }
    end
  end
end
