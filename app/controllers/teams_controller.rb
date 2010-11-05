class TeamsController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction  

  def index
    @teams = Team.order("#{sort_column} #{sort_direction}")
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
    3.times { @team.players.build }
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(params[:team])

    if @team.save
      redirect_to(@team, :notice => 'Team was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @team = Team.find(params[:id])

    if @team.update_attributes(params[:team])
      redirect_to(@team, :notice => 'Team was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to(teams_url)
  end

  private

  def sort_column
    params[:sort] ||= "wins"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
