Rails.application.routes.draw do
  root to: "standings#index"
  resources :posses, only: [:index]
  resources :cups, only: [:index]
  get "/login", to: redirect("/auth/slack"), as: :login
  get "/logout", to: "sessions#destroy", as: :logout
  get "/auth/slack/callback" => "sessions#create"
  namespace :api do
    namespace :v1 do
      resources :commands, only: [:create]
      resources :posses, only: [:index]
    end
  end

  namespace :admin do
    resources :students
    resources :cups, only: [:new, :create]
  end
end
