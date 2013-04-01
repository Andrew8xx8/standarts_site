RoR::Application.routes.draw do
  resources :standards, :helps, :news
  resources :session_histories, only: [:index, :destroy]
  resources :drafts do
    member do
      get "save"
    end
  end
  resources :users do
    resources :user_infos, :companies, only: [:new, :create]
  end
  resources :user_infos, :companies, except: [:new, :create]

  post "/login", :to => 'session#create', as: :signin_post
  match '/login', :to => 'session#new'
  match '/logout', :to => 'session#destroy'

  match "helper/number_selection" => "standards#number_selection"
  match "helper/take_several_patterns" => "standards#take_several_standards", as: :take_several_patterns
  match "helper/take_pattern" => "standards#take_pattern"
  match "pdf/:id" => "standards#pdf", as: :pdf

  root to: 'session#new'

  mount Ckeditor::Engine => '/ckeditor'
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id))(.:format)'
end
