Rails.application.routes.draw do
  scope "(:locale)", locale: /en|zh-TW/ do
    resources :projects

    scope path: 'projects/:project_id', as: :project do
      delete 'labels/remove/:id', to: 'labels#remove', as: :remove_label
    end

    get '/signup', to: 'users#new'
    resources :users, except: [:new]
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    namespace "admin" do
      root 'admin#index'
      resources :users
    end
  end

  root 'pages#home'
end
