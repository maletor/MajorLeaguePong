class RoundsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @game = Game.find(params[:game_id])
    @rounds = @game.rounds.order("number asc")
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
    @round = @game.rounds.new(params[:round])

    if @round.save
      redirect_to(game_rounds_path(@game), :notice => 'Round was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @game = Game.find(params[:game_id])
    @round = Round.find(params[:id])

    if @round.update_attributes(params[:round])
      redirect_to(game_rounds_path(@game), :notice => 'Round was successfully updated.')
    else
      render :action => "edit" 
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    @round = Round.find(params[:id])
    # LightHouse bug #4386 => dependent => destroy called before before_destroy effectively destroy all the shots
    # before analysis of whoever the asshole is can be done
    @round.forgive_asshole 
    @round.destroy

    redirect_to(game_rounds_url(@game))
  end
end
