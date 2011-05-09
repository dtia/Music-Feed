require 'net/http'

class Youtubevideo < ActiveRecord::Base
  def self.get_youtube_video(query)
    url = URI.parse('http://gdata.youtube.com/feeds/api/videos')
    req = Net::HTTP::Get.new(url.path + '?q=' + query + '&orderby=relevance&start-index=1&max-results=20&v=2&alt=json') #change count to 1
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    json_string = res.body
    json_results = ActiveSupport::JSON.decode(json_string)    
    json_results_obj = json_results["results"]
    
    json_results_obj.each do |search_result_obj|
      text = search_result_obj["text"]
      username = search_result_obj["from_user"]
      twitterfeed = Twitterfeed.new
      twitterfeed.text = text
      twitterfeed.user = username
      twitterfeed.save
    end
  end
  
  def self.get_song_name(tweet)
    return tweet.gsub("#nowplaying", '') #remove #nowplaying from tweet
  end
  
  private
    def self.concatenate_query(query)
      return query.gsub(' ', '+')
    end
end
