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
      get '/trash'      => 'dashboard#trash'
      get '/cache'      => 'dashboard#cache_clear',          as: :cache_clear
      get '/exp_cache'  => 'dashboard#explicit_cache_clear', as: :explicit_cache_clear
      get '/articles'   => 'articles#index'
      get '/categories' => 'categories#index'
      get '/languages'  => 'languages#index'
      get '/tags'       => 'tags#index'
      get '/tools'      => 'tools#index'
    end
  end

  # ARTICLES
  resources :articles, except: %i[index]
  get '/blog' => 'articles#index', as: :blog
  match '/articles/:id/publish' => 'articles#publish', via: %i[put patch], as: :publish_article
  match '/articles/:id/feature' => 'articles#feature', via: %i[put patch], as: :feature_article
  match '/articles/:id/delete'  => 'articles#delete',  via: %i[put patch], as: :delete_article

  # CATEGORIES
  resources :categories, except: %i[index show]
  match '/categories/:id/approve' => 'categories#approve', via: %i[put patch], as: :approve_category
  match '/categories/:id/feature' => 'categories#feature', via: %i[put patch], as: :feature_category
  match '/categories/:id/delete'  => 'categories#delete',  via: %i[put patch], as: :delete_category

  # LANGUAGES
  resources :languages, except: %i[index show]
  match '/languages/:id/approve' => 'languages#approve', via: %i[put patch], as: :approve_language
  match '/languages/:id/feature' => 'languages#feature', via: %i[put patch], as: :feature_language
  match '/languages/:id/delete'  => 'languages#delete',  via: %i[put patch], as: :delete_language

  # TAGS
  resources :tags, except: %i[index show]
  match '/tags/:id/approve' => 'tags#approve', via: %i[put patch], as: :approve_tag
  match '/tags/:id/feature' => 'tags#feature', via: %i[put patch], as: :feature_tag
  match '/tags/:id/delete'  => 'tags#delete',  via: %i[put patch], as: :delete_tag

  # TOOLS
  resources :tools, except: %i[index]
  match '/tools/:id/publish' => 'tools#publish', via: %i[put patch], as: :publish_tool
  match '/tools/:id/feature' => 'tools#feature', via: %i[put patch], as: :feature_tool
  match '/tools/:id/delete'  => 'tools#delete',  via: %i[put patch], as: :delete_tool

  # STATIC
  get '/directory' => 'static#directory'

  # ROOT
  root to: 'static#index'
end
