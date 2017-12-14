require 'sidekiq/web'

Rails.application.routes.draw do
  if Setting.has_module?(:home)
    root to: 'home#index'
  else
    root to: 'topics#index'
  end

  resources :topics do
    collection do
      get :feed
    end
  end

  devise_for :users, path: 'account', controllers: {
    registrations: :account,
    sessions: :sessions,
    omniauth_callbacks: 'auth/omniauth_callbacks'
  }

  # SSO
  namespace :auth do
    resource :sso, controller: 'sso' do
      collection do
        get :login
        get :provider
      end
    end
  end

  authenticate :user, -> (user) { user.admin? } do
    mount Sidekiq::Web, at: 'sidekiq'
    mount PgHero::Engine, at: "pghero"
    mount ExceptionTrack::Engine => "/exception-track"
  end

  namespace :admin do
    root to: 'home#index', as: 'root'
    resources :site_configs
    resources :users
    resources :sections
    resources :nodes
    resources :topics
  end

  constraints(id: /[#{User::LOGIN_FORMAT}]*/) do
    resources :users, path: ''
  end

end
