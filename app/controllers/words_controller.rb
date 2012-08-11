class WordsController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :new, :create, 
                                               :edit, :update]
  
  def index
    @words = current_user.words
  end

  def show
    find_word
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

  def edit
    find_word
  end

  def update
    find_word
    if @word.update_attributes(params[:word])
      flash[:success] = "Word has been updated."
      redirect_to word_path(@word)
    else
      flash[:error] = "Word has not been updated."
      render :action => :edit
    end
  end

  private
    def find_word
      @word = Word.find(params[:id])
    end
end
