class WordsController < ApplicationController
  before_filter :authenticate_user!, :only => [:index]
  
  def index
    @words = current_user.words
  end
end
