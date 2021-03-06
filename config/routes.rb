Rails.application.routes.draw do
  devise_for :users

  resources :discussions do
    collection do
      get "toptoday"
      get "topweek"
      get "topmonth"
      get "topyear"
      get "mosttoday"
      get "mostweek"
      get "mostmonth"
      get "mostyear"
    end

    member do
      put "plus", to: "discussions#plus"
      put "minus", to: "discussions#minus"
    end
  end

  get 'home/index'

  # Reroute the default devise routes for authentication
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
  end

  devise_scope :user do
    get '/register' => 'devise/registrations#new'
  end

  devise_scope :user do
    get '/logout' => 'devise/sessions#destroy'
  end

  resources :posts do
    resources :comments
  end

  resources :discussions do
    resources :replies
  end

  get '/blog' => 'posts#index'
  get '/forum' => 'discussions#index'

  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'
  get '/schedule' => 'pages#schedule'
  get '/stats' => 'pages#stats'

  get '/panel' => 'posts#panel', :as => 'panel'

  get '/categories' => 'categories#index', :as => 'categories'
  get '/categories' => 'categories#index'
  get '/categories/new' => 'categories#new', :as => 'new_category'
  delete '/categories/:id' => 'categories#destroy', :as => 'destroy_category'
  post '/categories' => 'categories#create'

  root to: 'posts#index'
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
