class AdminController < ApplicationController
  
  def index
    Twitterfeed.destroy_all
    Twitterfeed.parse_search_query("%23nowplaying")
    @twitterfeeds = Twitterfeed.find(:all)
    
    respond_to do |format|
      format.html
      format.js
    end
  end
end
