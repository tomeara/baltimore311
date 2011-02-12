require "net/http"
require "rubygems"
require "json"

class Post

@user = user
@pass = pass
@post_ws = uri
@host = host
  
  def self.send(code, detail, photo, createdAt, lat, long)
    payload ={
        "2648981" => code,
        "2648987" => createdAt,
        "2649018" => photo,
        "2649017" => detail,
        "2648997" => {
        "latitude" => lat,
        "longitude" => long
      }
    }.to_json
    
   req = Net::HTTP::Post.new(@post_ws)
    req.add_field "X-APP-TOKEN", api_token
    req.content_type = "application/json"
    req.basic_auth @user, @pass
    req.body = payload
    response = Net::HTTP.start(@host, 80) {|http| http.request(req) }
     puts "Response #{response.code} #{response.message}: #{response.body}"
  end

end