require 'net/http'

class Youtubevideo < ActiveRecord::Base
  def self.get_youtube_video(tweet)
    query = concatenate_query(get_song_name(tweet))
    puts query
    url = URI.parse('http://gdata.youtube.com/feeds/api/videos')
    req = Net::HTTP::Get.new(url.path + '?q=' + query + '&orderby=relevance&start-index=1&max-results=1&v=2&alt=json') #change count to 1
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    json_string = res.body
    
    json_results = ActiveSupport::JSON.decode(json_string)    
    feed_results = json_results["feed"]
    entry_obj = feed_results["entry"]
    
    entry_obj.each do |entry|
      id_obj = entry["id"]
      val_arr = id_obj.values
      vals = val_arr[0]
      video = vals[-11..-1]      
    end
    
    youtube_url = 'www.youtube.com/watch?v=' + video
    
    return youtube_url

  end
  
  def self.get_song_name(tweet)
    return tweet.gsub("#nowplaying", '') #remove #nowplaying from tweet
  end
  
  private
    def self.concatenate_query(query)
      return query.gsub(' ', '+')
    end
end
