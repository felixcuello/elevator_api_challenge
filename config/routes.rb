Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :buildings
      resources :elevators do
        member do
          get :move_down
          get :move_up
        end
      end
    end
  end

  match '*path', to: redirect('/'), via: :all
end
