class SearchWordsController < ApplicationController
  FILTERS = [["today", 1], ["last_week", 2], 
             ["last_month", 3]]

  def find_words_form
    @filters = FILTERS
  end

  def find_words
    find_words_with_specified_filter
    if @words.any?
      flash.now[:success] = "found"
      render :action => "find_words_form"
    else
      flash.now[:error] = "No words at that time"
      render :action => "find_words_form"
    end
  end

  private

    def find_words_with_specified_filter 
      criteria_code = params[:find][:search_criteria].to_i
      search_filter = FILTERS.find { |s| s[1] == criteria_code }
      @words = Word.send(search_filter[0])
    end
end
