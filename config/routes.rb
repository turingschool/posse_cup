Rails.application.routes.draw do
  root to: "standings#index"
  namespace :api do
    namespace :v1 do
      resources :commands, only: [:create]
      resources :posses, only: [:index]
    end
  end
end
