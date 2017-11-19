# @Author: baodongdong
# @Date:   2017-11-19T09:52:24+08:00
# @Last modified by:   baodongdong
# @Last modified time: 2017-11-19T17:18:23+08:00



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
end
