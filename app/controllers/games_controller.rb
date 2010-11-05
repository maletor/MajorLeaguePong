class GamesController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction  

  def index
    @games = Game.includes(:away, :home, :rounds).order("#{sort_column} #{sort_direction}")
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(params[:game])

    if @game.save
      redirect_to(game_rounds_path(@game), :notice => 'Game was successfully created.') 
    else
      render :action => "new" 
    end
  end

  def update
    @game = Game.find(params[:id])

    if @game.update_attributes(params[:game])
      redirect_to(@game, :notice => 'Game was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy

      redirect_to(games_url)
  end

  private

  def sort_column
    params[:sort] ||= "time"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
