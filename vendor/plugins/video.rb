#### Create classes for YouTube resources.
class Video < ActiveYouTube
  self.site = "http://gdata.youtube.com/feeds/api"

  ## To search by categories and tags
  def self.search_by_tags (*options)
    from_urls = []
    if options.last.is_a? Hash
      excludes = options.slice!(options.length-1)
      if excludes[:exclude].kind_of? Array
        from_urls << excludes[:exclude].map{|keyword| "-"+keyword}.join("/")
      else
        from_urls << "-"+excludes[:exclude]
      end
    end
    from_urls << options.find_all{|keyword| keyword =~ /^[a-z]/}.join("/")
    from_urls << options.find_all{|category| category =~ /^[A-Z]/}.join("%7C")
    from_urls.delete_if {|x| x.empty?}
    self.find(:all,:from=>"/feeds/api/videos/-/"+from_urls.reverse.join("/"))
  end
end

class User < ActiveYouTube
  self.site = "http://gdata.youtube.com/feeds/api"
end

class Standardfeed < ActiveYouTube
  self.site = "http://gdata.youtube.com/feeds/api"
end

class Playlist < ActiveYouTube
  self.site = "http://gdata.youtube.com/feeds/api"
end



##### Examples #######

#### VIDEO
  ## search for videos
  search = Video.find(:first, :params => {:vq => 'ruby', :"max-results" => '5'})
  puts search.entry.length

  ## video information of id = ZTUVgYoeN_o
  vid = Video.find("ZTUVgYoeN_o")
  puts vid.group.content[0].url

  ## video comments
  comments = Video.find_custom("ZTUVgYoeN_o").get(:comments)
  puts comments.entry[0].link[2].href

  ## searching with category/tags
  results = Video.search_by_tags("Comedy")
  puts results[0].entry[0].title
  # more examples:
  # Video.search_by_tags("Comedy", "dog")
  # Video.search_by_tags("News","Sports","football", :exclude=>["Comedy","soccer"])
  # Video.search_by_tags("News","Sports","football", :exclude=>"soccer")


#### STANDARDFEED
  ## retrieving standard feeds
  most_viewed = Standardfeed.find(:most_viewed, :params => {:time => 'today'})
  puts most_viewed.entry[0].group.content[0].url

#### USER
  ## user's profile - guthrie
  user_profile = User.find("guthrie")
  puts user_profile.link[1].href

  ## user's playlist - john
  user_playlist = User.find_custom("john").get(:playlists)
  puts user_playlist.link[1].href

  ## user's upload or favorites
  rick_video = User.find_custom("rick").get(:uploads)
  puts rick_video.entry[0].group.content[0].url

  ## user's subscription
  user_subscriptions = User.find_custom("guthrie").get(:subscriptions)
  puts user_subscriptions.to_yaml

#### PLAYLIST
  ## get playlist - multiple elements in playlist
  playlist = Playlist.find("EBF5D6DC4589D7B7")
  puts playlist.entry[0].group.content[0].url

  ## get playlist - single element in playlist
  playlist = Playlist.find("45C563323B344971")
  puts playlist.entry[0].group.content[0].url
