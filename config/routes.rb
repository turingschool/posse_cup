Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :point_awards, only: [:create]
      resources :posses, only: [:index]
    end
  end
end
