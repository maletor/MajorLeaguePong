class RoundsController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction  
  
  def index
    @game = Game.find(params[:game_id])
    @rounds = @game.rounds.order("number asc")

    flash.now[:info] = "This game has not yet been scored." if @rounds.blank?
  end

  def show
    @round = Round.find(params[:id])
  end

  def new
    @game = Game.find(params[:game_id])
    #@round = @game.rounds.build
    #@round.number = @game.rounds.count > 1 ? @game.rounds.count + 1 : 1
  end

  def edit
    @game = Game.find(params[:game_id])
    @round = Round.find(params[:id])
  end

  def create
    @game = Game.find(params[:game_id])
    @round = @game.rounds.new(params[:round])

    if @round.save
      redirect_to(game_rounds_path(@game), :flash => { :success => 'Round was successfully created.' })
    else
      render :action => "new"
    end
  end

  def update
    @game = Game.find(params[:game_id])
    @round = Round.find(params[:id])

    if @round.update_attributes(params[:round])
      redirect_to(game_rounds_path(@game), :flash => { :success => 'Round was successfully updated.' })
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

  private

  def sort_column
    params[:sort] ||= "number"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end



end
