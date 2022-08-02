class SearchController < ApplicationController
  def index
    search = params[:q]
    if search
      resp = Typhoeus.get("http://www.omdbapi.com/?apikey=#{ENV['OMDB_KEY']}&s", params: {s: search})
      @movies = JSON.parse(resp.body)["Search"]
    else
      @movies = []
    end
  end
end
