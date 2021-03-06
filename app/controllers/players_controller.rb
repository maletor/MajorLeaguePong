class PlayersController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction  

  def index
    @players = Player.includes(:shots, :team).order("#{sort_column} #{sort_direction}")
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create
    @player = Player.new(params[:player])

    if @player.save
      redirect_to(@player, :notice => 'Player was successfully created.')
    else
      render :action => "new" 
    end
  end

  def update
    @player = Player.find(params[:id])

    if @player.update_attributes(params[:player])
      redirect_to(@player, :notice => 'Player was successfully updated.') 
    else
      render :action => "edit" 
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    redirect_to(players_url) 
  end

  private

  def sort_column
    params[:sort] ||= "opp"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end


end
