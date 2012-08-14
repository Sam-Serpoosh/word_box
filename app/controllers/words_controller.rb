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
      success_action("Added word.", word_path(@word))
    else
      failed_action("Invalid Vocabulary/Meaning", "new")
    end
  end

  def edit
    find_word
  end

  def update
    find_word
    if @word.update_attributes(params[:word])
      success_action("Word has been updated.", word_path(@word))
    else
      failed_action("Word has not been updated.", "edit")
    end
  end

  private
    def find_word
      @word = Word.find(params[:id])
    end
end
