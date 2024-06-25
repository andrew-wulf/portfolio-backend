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
  post "/users" => "users#create"

  get "/tweets/timeline" => "tweets#timeline"
  get "/tweets/users/:id" => "tweets#user_tweets"
  get "/tweets/:id" => "tweets#show"

end
