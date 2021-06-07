require 'json'
require 'open-uri'

class GamesController < ApplicationController
  # Mes Methodes

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    @grid = []
    until @grid.size == @grid_size
      @grid << ('a'..'z').to_a.sample
    end
    return @grid
  end

  def valid?(guess, try)
    guess.chars.all? { |letter| guess.count(letter) <= try.count(letter) }
  end

  def english?(string)
    word_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{string}").read
    @result = JSON.parse(word_serialized)
    if @result["found"] == true
      @english = "The word #{string} was found"
    else
      @english = "#{string} Is not an english word"
    end
  end

  # Instances Method

  def new
    @letters = generate_grid(10).join(' ')
  end

  def score
    # english?(params[:word])
    valid?(params[:word], @letters)
  end
end
