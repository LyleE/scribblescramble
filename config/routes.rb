Vagrant::Application.routes.draw do
  root :to => 'draw#index'
  
  #resources :user_sessions
  post 'user_sessions/new' => 'user_sessions#create', as: :user_sessions

  #resources :users
  get 'users/:id' => 'users#show', as: :user
  delete 'users/:id' => 'users#destroy'
  get 'users/:id/edit' => 'users#edit', as: :edit_user
  post 'users/:id/edit' => 'users#update'
  
  get 'login' => 'user_sessions#new', as: :login
  get 'logout' => 'user_sessions#destroy', as: :logout

  get 'register' => "users#new", as: :register
  post 'register' => "users#create"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'draw#index'

  get 'play' => 'draw#index', as: :play
  post 'save' => 'draw#save'
  
  get 'rate' => 'rate#index', as: :rate
  post 'rate' => 'rate#save'

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
