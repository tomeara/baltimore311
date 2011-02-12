require 'rubygems'
require 'twitter'
require 'lib/post.rb'

@prev_id = 0
loop do
  sleep(1)
  search = Twitter::Search.new
  search.to("balt311").result_type("recent").per_page(1).each do |r|
      
      puts "#{r.id} - #{@prev_id}"
      if(r.id > @prev_id)
        @detail = r.text
        @timestamp = Time.now.strftime("%Y-%m-%d %I:%M:%S %p")
        if(!r.geo.nil?)
          @lat = "#{r.geo.coordinates[0]}"
          @long = "#{r.geo.coordinates[1]}"
        end
        @photo = r.text.match(/http:.*(\z|\s)/)
  
        if(r.text.downcase.include?("#dirtystreet"))
          @code = "DIRTYSTR"
        elsif(r.text.downcase.include?("#parkingviolation"))
          @code = "PKGVIOL"
        elsif(r.text.downcase.include?("#abandonedcar"))
            @code = "ABANDONV"
        elsif(r.text.downcase.include?("#pothole"))
            @code = "POTHOLES"
        elsif(r.text.downcase.include?("#rats"))
            @code = "RATRYBPR"
        end
  
        puts "detail - #{@detail}"
        puts "code - #{@code}"
        puts "timestamp - #{@timestamp}"
        puts "Lat - #{@lat}"
        puts "Long - #{@long}"
        puts "Photo - #{@photo}"
        puts "ID - #{r.id}"

        Post.send(@code, @detail, @photo, @timestamp, @lat, @long)
        @prev_id = r.id
      end
  end
end
