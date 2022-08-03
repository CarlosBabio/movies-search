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

  def all
    @colours = %w[red green blue yellow]
    @all_colours_arr = []
    @colours.each do |colour|
      resp = Typhoeus.get("http://www.omdbapi.com/?apikey=#{ENV['OMDB_KEY']}&s", params: {s: colour})
      @all_colours_arr << JSON.parse(resp.body)["Search"]
    end
  end

  # Logic to extract colour from movie title
  def bg_colour(movie_title)
    title_arr = movie_title.downcase.split(' ')
    match =  title_arr & @colours
    match.first
  end

  # Logic to get movie runtime from second API call using movie title given in first API call
  def movie_runtime(movie_title)
    response = Typhoeus.get("http://www.omdbapi.com/?apikey=#{ENV['OMDB_KEY']}&s", params: {t: movie_title})
    JSON.parse(response.body)["Runtime"]
  end
end
