IoStore::Engine.routes.draw do
  root :to => "products#index"

  
  resources :products do
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

    resources :products do
      collection do
        get 'remove_selected'
      end
    end

  end


end
