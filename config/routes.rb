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
      get '/'           => 'dashboard#index'
      get '/settings'   => 'dashboard#settings'
      get '/cache'      => 'dashboard#cache_clear', as: :cache_clear
      get '/languages'  => 'languages#index'
      get '/categories' => 'categories#index'
    end
  end

  # CATEGORIES
  resources :categories
  match '/categories/:id/approve' => 'categories#approve',via: %i[put patch], as: :approve_category
  match '/categories/:id/feature' => 'categories#feature',via: %i[put patch], as: :feature_category
  match '/categories/:id/delete'  => 'categories#delete', via: %i[put patch], as: :delete_category

  # LANGUAGES
  resources :languages
  match '/languages/:id/approve' => 'languages#approve',via: %i[put patch], as: :approve_language
  match '/languages/:id/feature' => 'languages#feature',via: %i[put patch], as: :feature_language
  match '/languages/:id/delete'  => 'languages#delete', via: %i[put patch], as: :delete_language

  # STATIC
  get '/directory' => 'static#directory'

  # ROOT
  root to: 'static#index'
end
