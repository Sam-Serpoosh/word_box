WordBox::Application.routes.draw do

  resources :users, :only => [:show, :new, :create, :edit, :update]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :words, :only => [:index, :show, :new, :create, :edit, :update, :destroy]

  post '/sessions',
    :to => "sessions#create",
    :as => "create_session"

  post '/find_words',
    :to => "search_words#find_words",
    :as => "find_words"
  
  match "/home", :to => "pages#home" 
  match "/about", :to => "pages#about" 
  match "/contact", :to => "pages#contact" 
  match "/signup", :to => "users#new" 
  match "/signin", :to => "sessions#new"
  match "/signout", :to => "sessions#destroy"
  match "/find_words", :to => "search_words#find_words_form"

  root :to => "pages#home"
end
