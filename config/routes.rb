Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users, path: '', path_names: {
    sign_in: 'api/login',
    sign_out: 'api/logout',
    registration: 'api/registration'
  },
  controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
  }, defaults: { format: :json }


  namespace :api do
    namespace :v1 do
      resources :buildings, only: %i[index show create update destroy]
      resources :elevators, only: %i[index show create update destroy] do
        member do
          get :move_down
          get :move_up
        end
      end
    end
  end

  match '*path', to: redirect('/'), via: :all
end
