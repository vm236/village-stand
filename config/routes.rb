Geomarket::Application.routes.draw do
  post '/marketplace' => 'pages#marketplace'
  resources :orders

  resources :cart_items

  resources :carts

  resources :votes

  resources :farms

  resources :products
  
devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions" }

  devise_scope :user do
    get "/login", :to => "devise/sessions#new", :as => :new_user_session
    get "/logout", :to => "devise/sessions#destroy", :as => :destroy_user_session
    get "/profile", :to => "devise/registrations#edit", :as => :profile
  end

  resources :users

  get 'profile' => 'registrations#edit', :as => 'profile'

#  get 'pages/home', :as => '/home'
  get 'home' => 'pages#home', :as => 'home'
  get 'admin' => 'admins#index', :as => 'admin'
  get 'marketplace' => 'pages#marketplace', :as => 'marketplace'
  get 'route' => 'pages#route', :as => 'route'
  get 'villageboard' => 'pages#village_board', :as => 'villageboard'
  get 'farmer' => 'pages#farmer', :as => 'farmer'
  get 'my_farm' => 'pages#my_farm', :as => 'my_farm'



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
