class YoutubevideosController < ApplicationController
  # GET /youtubevideos
  # GET /youtubevideos.xml
  def index
    @youtubevideos = Youtubevideo.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @youtubevideos }
    end
  end

  # GET /youtubevideos/1
  # GET /youtubevideos/1.xml
  def show
    @youtubevideo = Youtubevideo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @youtubevideo }
    end
  end

  # GET /youtubevideos/new
  # GET /youtubevideos/new.xml
  def new
    @youtubevideo = Youtubevideo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @youtubevideo }
    end
  end

  # GET /youtubevideos/1/edit
  def edit
    @youtubevideo = Youtubevideo.find(params[:id])
  end

  # POST /youtubevideos
  # POST /youtubevideos.xml
  def create
    @youtubevideo = Youtubevideo.new(params[:youtubevideo])

    respond_to do |format|
      if @youtubevideo.save
        flash[:notice] = 'Youtubevideo was successfully created.'
        format.html { redirect_to(@youtubevideo) }
        format.xml  { render :xml => @youtubevideo, :status => :created, :location => @youtubevideo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @youtubevideo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /youtubevideos/1
  # PUT /youtubevideos/1.xml
  def update
    @youtubevideo = Youtubevideo.find(params[:id])

    respond_to do |format|
      if @youtubevideo.update_attributes(params[:youtubevideo])
        flash[:notice] = 'Youtubevideo was successfully updated.'
        format.html { redirect_to(@youtubevideo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @youtubevideo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /youtubevideos/1
  # DELETE /youtubevideos/1.xml
  def destroy
    @youtubevideo = Youtubevideo.find(params[:id])
    @youtubevideo.destroy

    respond_to do |format|
      format.html { redirect_to(youtubevideos_url) }
      format.xml  { head :ok }
    end
  end
end
