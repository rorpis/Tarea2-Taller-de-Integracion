Rails.application.routes.draw do

  get '/submissions/list', to: 'submissions#list'
  resources :submissions
  resources :comments
  devise_for :users
  resources :submissions do
    member do
      put "like", to: "submissions#upvote"
      put "dislike", to: "submissions#downvote"
    end
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'submissions#index'
end
