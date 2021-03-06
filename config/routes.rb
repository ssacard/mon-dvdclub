ActionController::Routing::Routes.draw do |map|
  map.connect '/infos/:page_name', :controller => 'static', :action => 'page'
  map.connect '/facebook_logout', :controller => 'sessions', :action => 'logout_facebook'

  map.with_options :controller => 'users' do |user|
    user.forgot_password    '/forgot_password',         :action => 'forgot_password'
    user.reset_request_done '/reset_request_done',      :action => 'reset_request_done'
    user.change_password    '/change_password/:secret', :action => 'change_password'
    user.register           '/register',                :action => 'new'
    user.facebook_connect   '/facebook_connect',        :action => 'facebook_connect', :conditions => { :method => :post }
    user.settings           '/settings',                :action => 'edit'
  end

  map.resources :users
  map.resources :user_dvd_clubs
  map.resources :dvds

  map.resource :session
  map.login  '/login',       :controller => 'sessions', :action => 'new'
  map.logout '/logout',      :controller => 'sessions', :action => 'destroy'
  map.join   '/join/:token', :controller => 'users',    :action => 'new'

  map.connect '/dvd_clubs/:id/invite', :controller => 'dvd_clubs', :action => 'invite'

  map.resources :dvd_categories do |dvd_category|
    dvd_category.resources :dvds
  end

  map.resources :dvd_clubs, :member => {:join => :post}, :collection => { :blacklist => :get }

  map.resources :user_dvd_clubs
  map.resources :waiting_lists

  map.admin 'admin', :controller => 'admin', :action => 'index'
  map.with_options :path_prefix => 'admin', :name_prefix => 'admin_' do |admin|
    admin.resources :dvd_formats, :controller => 'admin/dvd_formats'
    admin.resources :dvd_clubs  , :controller => 'admin/dvd_clubs', :member => { :info => :get }
    admin.resources :users      , :controller => 'admin/users'
    admin.resources :settings   , :controller => 'admin/settings'
  end

  # Install the default routes as the lowest priority.
  map.root :controller => "public", :action => "index"
  map.home '/home', :controller => "home", :action => "index"
  map.mydvds '/home/dvds', :controller => "home", :action => "dvds"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
