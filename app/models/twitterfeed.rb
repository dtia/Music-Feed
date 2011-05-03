require 'net/http'

class Twitterfeed < ActiveRecord::Base
    validates_presence_of :text
    validates_uniqueness_of :user
    
    def self.parse_public_timeline
      url = URI.parse('http://api.twitter.com/1/statuses/public_timeline.json')
      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      json_string = res.body
      tweets = ActiveSupport::JSON.decode(json_string)    

      tweets.each do |tweet|      
        twittertext = tweet["text"]
        user_obj = tweet["user"]
        username = user_obj["screen_name"]
    
        twitterfeed = Twitterfeed.new
        twitterfeed.text = twittertext
        twitterfeed.user = username
        twitterfeed.save
      end
    end    
    
    def self.parse_trending_topics
      url = URI.parse('http://api.twitter.com/1/trends/2487956.json')
      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      json_string = res.body
      trending_topics = ActiveSupport::JSON.decode(json_string)    
      trending_topics.each do |trending_topic|
        trending_topic_obj = trending_topic["trends"]
        i=1
        trending_topic_obj.each do |topic|
          name = topic["name"]
          puts "#{name}"
          twitterfeed = Twitterfeed.new
          twitterfeed.text = name
          twitterfeed.user = i
          twitterfeed.save
          i=i+1
        end
      end
  end
    
    def self.total_num_items
      @twitterfeeds.sum { |twitterfeed| twitterfeed.quantity }
    end
end
