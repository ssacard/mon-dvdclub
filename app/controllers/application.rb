# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authenticate 
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '7d18b0ac5d9ddaa4e0910ee1167792c0'
  
  around_filter :set_language

private 
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "DVDclub" && password == "SACARD"
    end if ENV['RAILS_ENV'] == 'production'
  end
  
  def set_language
    Gibberish.use_language(session[:language] || 'fr') { yield }
  end
end
