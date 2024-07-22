Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post "/sessions" => "sessions#create"
  get "/login" => "sessions#login"

  get "/user" => "users#current_user_info"
  post "/user/update" => "users#update"
  get "/recommendations" => "users#who_to_follow"

  get "/users/exists" => "users#exists"
  get "/users/:username" => "users#show"
  post "/users/:username/follow" => "users#follow_toggle"

  post "/users" => "users#create"

  get "/tweets/timeline" => "tweets#timeline"
  get "/tweets/suggested" => "tweets#suggested"
  get "/tweets/users/:username" => "tweets#user_tweets"

  get "/tweets/:id" => "tweets#show"
  post "/tweets/:id/like" => "tweets#like_toggle"
  post "/tweets/:id/retweet" => "tweets#retweet_toggle"

  post "/tweets/new" => "tweets#create"
  post "/tweets/subtweet" => "tweets#subtweet"


  post "/movies/search" => "movie_battle#search"
  post "/movies/data/:id" => "movie_battle#movie_data"

end
