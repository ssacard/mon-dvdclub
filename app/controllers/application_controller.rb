# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authenticate 
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '7d18b0ac5d9ddaa4e0910ee1167792c0'

  before_filter :set_locale
  
  allow :exec => :check_auth, :redirect_to => '/'
 
  def check_auth
    unless current_user.nil? or current_user.active?
      flash[:notice] = %{Votre compte est désactivé !}
      return false
   end
   true
  end

private 
  def authenticate
    # TODO : Dead-code ? 
    authenticate_or_request_with_http_basic do |username, password|
      username == "DVDclub" && password == "SACARD"
    end if ENV['RAILS_ENV'] == 'production'
  end
  
  def set_locale
    # update session if passed
    session[:locale] = params[:locale] if params[:locale]

    # set locale based on session or default 
    I18n.locale = session[:locale] || I18n.default_locale
  end
end
