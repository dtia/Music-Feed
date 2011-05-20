class TwitterfeedsController < ApplicationController
  # GET /twitterfeeds
  # GET /twitterfeeds.xml
  def index
    Twitterfeed.destroy_all
    #Twitterfeed.parse_public_timeline
    #Twitterfeed.parse_trending_topics
    
    Twitterfeed.parse_search_query("%23nowplaying")
    
    #Youtubevideo.get_youtube_video(Youtubevideo.concatenate_query("whats my name"))
    @twitterfeeds = Twitterfeed.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @twitterfeeds }
    end
  end
  
  def play_video
    @video_id = params[:video_id]
    @title = params[:title]
    respond_to do |format|
      format.js
    end
  end
  
  def play_all
    @twitterfeeds = Twitterfeed.find(:all)
    @video_list = Twitterfeed.get_all_videos_for_page(@twitterfeeds)
    respond_to do |format|
      format.js
    end
  end

  # GET /twitterfeeds/1
  # GET /twitterfeeds/1.xml
  def show
    @twitterfeed = Twitterfeed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @twitterfeed }
    end
  end

  # GET /twitterfeeds/new
  # GET /twitterfeeds/new.xml
  def new
    @twitterfeed = Twitterfeed.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @twitterfeed }
    end
  end

  # GET /twitterfeeds/1/edit
  def edit
    @twitterfeed = Twitterfeed.find(params[:id])
  end

  # POST /twitterfeeds
  # POST /twitterfeeds.xml
  def create
    @twitterfeed = Twitterfeed.new(params[:twitterfeed])

    respond_to do |format|
      if @twitterfeed.save
        flash[:notice] = 'Twitterfeed was successfully created.'
        format.html { redirect_to(@twitterfeed) }
        format.xml  { render :xml => @twitterfeed, :status => :created, :location => @twitterfeed }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @twitterfeed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /twitterfeeds/1
  # PUT /twitterfeeds/1.xml
  def update
    @twitterfeed = Twitterfeed.find(params[:id])

    respond_to do |format|
      if @twitterfeed.update_attributes(params[:twitterfeed])
        flash[:notice] = 'Twitterfeed was successfully updated.'
        format.html { redirect_to(@twitterfeed) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @twitterfeed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /twitterfeeds/1
  # DELETE /twitterfeeds/1.xml
  def destroy
    @twitterfeed = Twitterfeed.find(params[:id])
    @twitterfeed.destroy

    respond_to do |format|
      format.html { redirect_to(twitterfeeds_url) }
      format.xml  { head :ok }
    end
  end
end
