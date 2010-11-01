class ShotsController < ApplicationController
  load_and_authorize_resource
  
  # GET /shots
  # GET /shots.xml
  def index
    @game = Game.find(params[:game_id])
    @shots = @game.shots.order("round asc")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shots }
    end
  end

  # GET /shots/1
  # GET /shots/1.xml
  def show
    @shot = Shot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shot }
    end
  end

  # GET /shots/new
  # GET /shots/new.xml
  def new
    @game = Game.find(params[:game_id])
    @shots = []
    6.times { |i| @shots << @game.shots.build(:player_id => i) }
  end

  # GET /shots/1/edit
  def edit
    @shot = Shot.find(params[:id])
  end

  # POST /shots
  # POST /shots.xml
  def create
    @game = Game.find(params[:game_id])
    @shot = @game.shots.new(params[:shot])

      if @shot.save
        redirect_to(game_shots_path(@game), :notice => 'Shot was successfully created.')
      else
         render :action => "new"
      end
  end

  # PUT /shots/1
  # PUT /shots/1.xml
  def update
    @shot = Shot.find(params[:id])

    respond_to do |format|
      if @shot.update_attributes(params[:shot])
        format.html { redirect_to(@shot, :notice => 'Shot was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shots/1
  # DELETE /shots/1.xml
  def destroy
    @shot = Shot.find(params[:id])
    @shot.destroy

    respond_to do |format|
      format.html { redirect_to(shots_url) }
      format.xml  { head :ok }
    end
  end
end
