Rails.application.routes.draw do
  scope "(:locale)", locale: /en|zh-TW/ do
    resources :projects

    get '/signup', to: 'users#new'
    resources :users, except: [:new]
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    namespace "admin" do
      root 'admin#index'
    end
  end

  root 'pages#home'
end
