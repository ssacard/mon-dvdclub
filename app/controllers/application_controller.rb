# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include AuthenticatedSystem
  helper :all
  protect_from_forgery

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

  # def authenticate
  #   # TODO : Dead-code ?
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == "DVDclub" && password == "SACARD"
  #   end if ENV['RAILS_ENV'] == 'production'
  # end

  def set_locale
    # update session if passed
    session[:locale] = params[:locale] if params[:locale]
    # set locale based on session or default 
    I18n.locale = session[:locale] || I18n.default_locale
  end

end