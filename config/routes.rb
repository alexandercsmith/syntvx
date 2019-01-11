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
      get    '/'                    => 'dashboard#index'
      get    '/settings'            => 'dashboard#settings'
      get    '/api_keys'            => 'dashboard#keys',            as: :api_keys
      post   '/api_key'             => 'dashboard#create_api_key',  as: :api_key
      delete '/api_key/:id'         => 'dashboard#destroy_api_key', as: :destroy_api_key
      get    '/trash'               => 'dashboard#trash'
      get    '/cache'               => 'dashboard#cache_clear',     as: :cache_clear
      get    '/exp_cache'           => 'dashboard#exp_cache_clear', as: :explicit_cache_clear
      get    '/articles'            => 'articles#index'
      get    '/articles/trash'      => 'articles#trash',            as: :articles_trash
      get    '/article/:id'         => 'articles#info',             as: :article_info
      get    '/articles/new'        => 'articles#new',              as: :new_article
      get    '/articles/:id/edit'   => 'articles#edit',             as: :edit_article
      get    '/categories'          => 'categories#index'
      get    '/categories/trash'    => 'categories#trash',          as: :categories_trash
      get    '/category/:id'        => 'categories#info',           as: :category_info
      get    '/categories/new'      => 'categories#new',            as: :new_category
      get    '/categories/:id/edit' => 'categories#edit',           as: :edit_category
      get    '/languages'           => 'languages#index'
      get    '/languages/trash'     => 'languages#trash',           as: :languages_trash
      get    '/language/:id'        => 'languages#info',            as: :language_info
      get    '/languages/new'       => 'languages#new',             as: :new_language
      get    '/languages/:id/edit'  => 'languages#edit',            as: :edit_language
      get    '/tags'                => 'tags#index'
      get    '/tags/trash'          => 'tags#trash',                as: :tags_trash
      get    '/tag/:id'             => 'tags#info',                 as: :tag_info
      get    '/tags/new'            => 'tags#new',                  as: :new_tag
      get    '/tags/:id/edit'       => 'tags#edit',                 as: :edit_tag
      get    '/tools'               => 'tools#index'
      get    '/tools/trash'         => 'tools#trash',               as: :tools_trash
      get    '/tool/:id'            => 'tools#info',                as: :tool_info
      get    '/tools/new'           => 'tools#new',                 as: :new_tool
      get    '/tools/:id/edit'      => 'tools#edit',                as: :edit_tool
    end
  end

  # ARTICLES
  resources :articles, except: %i[index new edit]
  get '/blog' => 'articles#index', as: :blog
  get '/blog/tag/:id' => 'articles#tagged', as: :blog_tag
  match '/articles/:id/publish' => 'articles#publish', via: %i[put patch], as: :publish_article
  match '/articles/:id/feature' => 'articles#feature', via: %i[put patch], as: :feature_article
  match '/articles/:id/delete'  => 'articles#delete',  via: %i[put patch], as: :delete_article

  # CATEGORIES
  resources :categories, except: %i[index show new edit]
  match '/categories/:id/approve' => 'categories#approve', via: %i[put patch], as: :approve_category
  match '/categories/:id/feature' => 'categories#feature', via: %i[put patch], as: :feature_category
  match '/categories/:id/delete'  => 'categories#delete',  via: %i[put patch], as: :delete_category

  # LANGUAGES
  resources :languages, except: %i[index show new edit]
  match '/languages/:id/approve' => 'languages#approve', via: %i[put patch], as: :approve_language
  match '/languages/:id/feature' => 'languages#feature', via: %i[put patch], as: :feature_language
  match '/languages/:id/delete'  => 'languages#delete',  via: %i[put patch], as: :delete_language

  # TAGS
  resources :tags, except: %i[index show new edit]
  match '/tags/:id/approve' => 'tags#approve', via: %i[put patch], as: :approve_tag
  match '/tags/:id/feature' => 'tags#feature', via: %i[put patch], as: :feature_tag
  match '/tags/:id/delete'  => 'tags#delete',  via: %i[put patch], as: :delete_tag

  # TOOLS
  resources :tools, except: %i[index show new edit]
  get   '/resource/:id'      => 'tools#show', as: :resource
  match '/tools/:id/publish' => 'tools#publish', via: %i[put patch], as: :publish_tool
  match '/tools/:id/feature' => 'tools#feature', via: %i[put patch], as: :feature_tool
  match '/tools/:id/delete'  => 'tools#delete',  via: %i[put patch], as: :delete_tool

  # STATIC
  get '/directory' => 'static#directory'

  # ROOT
  root to: 'static#index'
end
