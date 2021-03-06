Rails.application.routes.draw do

  devise_for :stylists
  devise_for :users, skip: [:sessions]
  as :user do
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    match 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session,
    :via => Devise.mappings[:user].sign_out_via
  end

  root 'static_pages#home'
  get 'help' => 'static_pages#help'

  # API routes
  namespace :api, defaults: { format: :json } do
    resource :users, only: [:show, :update]
    resource :addresses, only: [:show, :create, :update, :destroy]
    resource :customers, only: [:show, :create, :update, :destroy]

    resources :kiqs, except: [:new, :edit]
    resources :conversations, only: [:index, :show, :update]
    resources :messages, only: :create
  end

  # stylists specific routes
  namespace :stylists do
    get 'dashboard' => 'pages#dashboard'
    resources :items
    resources :kiqs, only: [:index, :show, :edit, :update] do
      member do
        resources :charges, only: [:create, :destroy]
      end
    end
    resources :conversations, only: [:index, :show, :update]
    resources :users, only: [:index, :show], path: 'clients' do
      resources :messages, only: [:new, :create]
    end
  end

  # angular routes
  get '/signup/*all' => 'application#index'
  get '/profile' => 'application#index'
  get '/profile/*all' => 'application#index'

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
