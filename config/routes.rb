Rails.application.routes.draw do

  get 'carts/show', as: "cart"

  root 'guests#index'
 # do we need route w/ callback?
  get "/auth/:provider/callback" =>  "sessions#create" # called from the provider (github) OAuth strategy and not by a link the user clicks on
  get "/sessions", to: "sessions#index", as: "sessions"
  delete "/sessions", to: "sessions#destroy", as: "logout"


  resources :products do
    resources :reviews, except: [:index, :show]
  end

  post "/products/:id", to: "reviews#create"

  # get "/products/:id/add_to_cart", to: "order_items#add_to_cart", as: "add_to_cart"

  patch "/products/:id/retire", to: "products#retire_product", as: "retire_product"

  patch "/products/:id/reinstate", to: "products#reinstate_product", as: "reinstate_product"

  resources :merchants, only: [:new, :create, :show]

  resources :order_items, except: [:show]

  resources :orders, except: [:index]
  resources :categories, only: [:create, :new]

  get 'category/:category_id/products', to: 'categories#show', as: 'category'
  get 'merchant/:merchant_id/products', to: 'merchants#products', as: 'merchant-products'


  get "/sessions/login_failure", to: "sessions#login_failure", as: "login_failure"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
