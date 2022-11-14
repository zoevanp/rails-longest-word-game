require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = ''
    10.times { @letters << alphabet.sample }
  end

  def included?
    a = @player_answer.chars
    a.all? { |letter| a.count(letter) <= @letters.count(letter) }
  end

  def english_word?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@player_answer}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    @player_answer = params[:player_answer]
    @letters = params[:letters]
    if included? && english_word?
      @results = 'AMAZING, +3 points'
    else
      @results = 'ERROR, your word is not using the right letters and/or is not english'
    end
  end
end
