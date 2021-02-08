Rails.application.routes.draw do
  scope "(:locale)", locale: /en|zh-TW/ do
    resources :projects

    get '/signup', to: 'users#new'
    resources :users, except: [:new]
  end
  root 'pages#home'
end
