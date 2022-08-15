require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
    @letters
  end

  def letter_in_grid?
    @answer.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    word['found']
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    grid_letters = @grid.each_char { |letter| print letter, '' }
    if !letter_in_grid?
      @score = "Sorry, but #{@answer} can’t be built out of #{grid_letters}."
    elsif !english_word?
      @score = "Sorry but #{@answer} does not seem to be an English word."
    else
      @score = "Congratulation! #{@answer} is a valid English word."
    end
  end
end
