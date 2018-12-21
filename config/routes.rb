Rails.application.routes.draw do
  # ADMIN
  devise_for :admins,
  path: 'admins',
  path_names: {
    sign_in: 'login'
  },
  controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }
  authenticate :admin do
    namespace :admins do
      get '/'         => 'dashboard#index'
      get '/settings' => 'dashboard#settings'
      get '/cache'    => 'dashboard#cache_clear', as: :cache_clear
    end
  end

  # STATIC

  # ROOT
  root to: 'static#index'
end
