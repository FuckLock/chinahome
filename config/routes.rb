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

  namespace :admin do
    root to: 'home#index', as: 'root'
    resources :site_configs
  end

  constraints(id: /[#{User::LOGIN_FORMAT}]*/) do
    resources :users, path: ''
  end

end
