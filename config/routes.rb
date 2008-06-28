ActionController::Routing::Routes.draw do |map|

  map.resources :users
  map.resource :session  
  map.resources :formats
  
  map.resources :dvd_categories do |dvd_category|
    dvd_category.resources :dvds
  end
  map.resources :club_topics do |club_topic|
    club_topic.resources :dvd_clubs
  end
  
  map.resources :dvd_clubs do |dvd_club|
    dvd_club.resources :dvds
  end
  
  map.resources :user_dvd_clubs
  map.resources :waiting_lists
  
  map.admin 'admin', :controller => 'admin', :action => 'index'
  map.with_options :path_prefix => 'admin', :name_prefix => 'admin_' do |admin|
    admin.resources :dvd_formats, :controller => 'admin/dvd_formats'
    admin.resources :club_topics, :controller => 'admin/club_topics'
  end
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.root :controller => "public", :action => "index"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
