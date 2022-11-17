Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # esto lo dejo como ayuda memoria
  # delete '/products/:id', to: 'products#destroy'
  # patch '/products/:id', to: 'products#update'
  # post '/products', to: 'products#create'
  # get '/products', to: 'products#index'
  # get '/products/new', to: 'products#new', as: :new_product
  # get '/products/:id', to: 'products#show', as: :product
  # get '/products/:id/edit', to: 'products#edit', as: :edit_product
  
  # las líneas anteriores se reemplazan por la que sigue, son equivalentes
  resources :categories, except: :show
  resources :products, path: '/'
  


  # Defines the root path route ("/")
  # root "articles#index"
end
