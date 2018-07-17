class Api::GalleriesController < ApplicationController
  def index
    response = Unirest.get(
      "https://api.harvardartmuseums.org/gallery?apikey=#{ENV["API_KEY"]}",
      headers: {
        "X-User-Email" => ENV["API_EMAIL"], 
        "Authorization" => "Token token=#{ENV["API_KEY"]}"
      }
    )
    item_array = response.body["records"]
    galleries = item_array
      .select {|gallery| gallery["theme"] != nil}
      .map {|gallery| {floor: gallery["floor"], name: gallery["name"], theme: gallery["theme"], labeltext: gallery["labeltext"]}}
    render json: galleries
  end
  #   user_friendly_galleries = galleries.map{|gallery| gallery["floor"]}
  #   render json: user_friendly_galleries
  # end
end
