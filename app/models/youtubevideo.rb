require 'net/http'

class Youtubevideo < ActiveRecord::Base
  def self.get_youtube_video(tweet)
    query = format_query(get_song_name(tweet))
    url = URI.parse('http://gdata.youtube.com/feeds/api/videos')
    http_url = url.path + '?q=' + query + '&orderby=relevance&start-index=1&max-results=1&v=2&alt=json'
    req = Net::HTTP::Get.new(http_url)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    json_string = res.body
    #puts "json string: #{json_string}"
    json_results = ActiveSupport::JSON.decode(json_string)    
    feed_results = json_results["feed"]
    entry_obj = feed_results["entry"]
    
    video = nil
    title = nil
    
    if entry_obj != nil
      entry_obj.each do |entry|
        
        id_obj = entry["id"]
        val_arr = id_obj.values
        vals = val_arr[0]
        video = vals[-11..-1]
        
        title_obj = entry["title"]
        val_arr = title_obj.values
        title = val_arr[0]
      end
    end

    return [video, title]

  end
  
  def self.get_song_name(tweet)
    
    #puts "the tweet is #{tweet}"
    r1 = Regexp.new(/\s?#\w+\s?/) #[^@(.+)]
    r2 = Regexp.new(/(http|https)?:?\/?\/?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix)
    r3 = Regexp.new(/@\w+/)
    r4 = Regexp.new(/\s?RT\s?/)
    r5 = Regexp.new(/\\u..../)
    song = tweet.gsub(r1, '') #remove #tags from tweet
    song = song.gsub(r2, '')
    song = song.gsub(r3, '')
    song = song.gsub(r4, '')
    song = song.gsub(r5, '')
    #puts "the song is #{song}"
    return song
  end
  
  private
    def self.format_query(query)
      formatted_query = CGI.escape(query)
      formatted_query = formatted_query.gsub(' ', '+')
      return formatted_query
    end
end
