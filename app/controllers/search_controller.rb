class SearchController < ApplicationController
  def index
    @colours = %w[red green blue yellow]
    search = params[:q]
    if search
      resp = Typhoeus.get("http://www.omdbapi.com/?apikey=#{ENV['OMDB_KEY']}&s", params: { s: search })
      @movies = JSON.parse(resp.body)["Search"]
    else
      @movies = []
    end
  end

  def all
    @colours = %w[red green blue yellow]
    @all_colours_arr = []

    # Searching for each colour individually then pushing each search result to an array
    @colours.each do |colour|
      resp = Typhoeus.get("http://www.omdbapi.com/?apikey=#{ENV['OMDB_KEY']}&s", params: { s: colour })
      @all_colours_arr << JSON.parse(resp.body)["Search"]
    end
  end

  # Logic to get movie runtime from second API call using movie title given in first API call
  def movie_runtime(movie_title)
    response = Typhoeus.get("http://www.omdbapi.com/?apikey=#{ENV['OMDB_KEY']}&s", params: { t: movie_title })
    JSON.parse(response.body)["Runtime"]
  end
end
