Rails.application.routes.draw do
  resources :posts do
    member do
      get 'like'
      get 'unlike'
    end
    resources :comments
  end
  get 'sessions/login'

  get 'sessions/logout'
  
  get 'userallposts' => 'posts#userallposts', as: 'userallposts'

  get 'most_popular' => 'posts#most_popular', as: 'most_popular'
  get 'active_posts' => 'posts#active_posts', as: 'active_posts'

  post 'sessions' => 'sessions#create'

  get 'favorites' => 'posts#favorites', as: 'favorites'
  post 'posts/add_to_favorites' => 'posts#add_to_favorite'
  post 'posts/remove_from_favorites' => 'posts#remove_from_favorite'

  get 'registration' => 'users#new', as: 'registration'

  get 'users' => 'users#index'
 # get 'user' => 'users#show'
  post 'users' => 'users#create'
  #post 'post/rates' => 'posts#rates'

  #get 'like' => 'posts#like', as: :like
  #get 'unlike' => 'posts#unlike', as: :unlike

  get 'tags/:tag', to: 'posts#index', as: :tag

  resources :posts, :users, :sessions
 
  
   root 'posts#index'

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
