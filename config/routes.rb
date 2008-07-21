ActionController::Routing::Routes.draw do |map|

  map.with_options :controller => 'users' do |user|
    user.forgot_password    '/forgot_password',         :action => 'forgot_password'
    user.reset_request_done '/reset_request_done',      :action => 'reset_request_done'
    user.change_password    '/change_password/:secret', :action => 'change_password'
    user.register           '/register',                :action => 'new'
    user.settings           '/settings',                :action => 'edit'
  end
  
  map.resources :users
  map.resources :user_dvd_clubs
  
  map.resource :session  
  map.login  '/login',       :controller => 'sessions', :action => 'new'
  map.logout '/logout',      :controller => 'sessions', :action => 'destroy'
  map.join   '/join/:token', :controller => 'users', :action => 'new'
  
  map.connect '/dvd_clubs/:dvd_club_id/new_dvd', :controller => 'dvd_clubs', :action => 'new_dvd'
  map.connect '/dvd_clubs/:id/invite', :controller => 'dvd_clubs', :action => 'invite'

  map.resources :dvd_categories do |dvd_category|
    dvd_category.resources :dvds
  end
  map.resources :club_topics do |club_topic|
    club_topic.resources :dvd_clubs
  end
  
  map.resources :dvd_clubs, :member => {:join => :post}
  
  map.resources :user_dvd_clubs
  map.resources :waiting_lists
  
  map.admin 'admin', :controller => 'admin', :action => 'index'
  map.with_options :path_prefix => 'admin', :name_prefix => 'admin_' do |admin|
    admin.resources :dvd_formats, :controller => 'admin/dvd_formats'
    admin.resources :club_topics, :controller => 'admin/club_topics'
  end

  # Install the default routes as the lowest priority.
  map.root :controller => "public", :action => "index"
  map.home '/home', :controller => "home", :action => "index"
  map.mydvds '/home/dvds', :controller => "home", :action => "dvds"
  
  # TEMPORARY !!!!!!!!!!!!!!!!
  map.reset_db '/reset_db', :controller => 'home', :action => 'reset_db'
  map.restore_db '/restore_db', :controller => 'home', :action => 'restore_db'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
