Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  devise_scope :user do 
    get "/users" => "users#index" 
    get "/users/:username" => 'users#show'
  end


  resources :home do
    collection do
      get 'add_to_cart'
    end
  end

  resources :carts do
    collection do
      get 'remove_item'
      get 'increase_quantity'
      get 'decrease_quantity'
      get 'remove_selected_items'

      get 'add'
    end
  end


  resources :addresses do
    collection do
      get 'get_cities'
      get 'get_sub_cities'
      post 'select_default'
    end
  end


  resources :orders do
    collection do
      get 'add_product'
    end
  end
  

  namespace :admin do
    root "base#index"
    resources :users
  end

  if ::Rails.env.production? 
    match '*path', via: :all, to: 'home#error_404'
  end
end
