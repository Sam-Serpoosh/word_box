class WordsController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :new, :create]
  
  def index
    @words = current_user.words
  end

  def show
    @word = Word.find(params[:id])
  end
  
  def new
    @word = Word.new
  end

  def create
    @word = current_user.words.build(params[:word]) 
    if @word.save
      flash[:success] = "Added word."
      redirect_to word_path(@word)
    else
      flash[:error] = "Invalid Vocabulary/Meaning"
      render :action => "new"
    end
  end
end
