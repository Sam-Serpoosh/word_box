def add_new_word(vocabulary, meaning)
  visit words_path
  click_link "Add Word"
  fill_in "Vocabulary", :with => vocabulary
  fill_in "Meaning", :with => meaning 
  click_button "Create Word"
end
