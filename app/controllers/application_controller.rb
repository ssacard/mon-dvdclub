# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  AppSecretFacebook = 'f182ee8dcb0e50247f9f90cc0bb4ed19'

  include AuthenticatedSystem
  include Facebooker2::Rails::Controller
  helper :all
  helper_method :fb_user

  protect_from_forgery

  allow :exec => :check_auth, :redirect_to => '/'

  def check_auth
    if ( ! current_user.nil? ) && ! current_user.active?
      self.current_user.forget_me
      self.current_user = nil
      cookies.delete :auth_token
      reset_session
      flash[:notice] = %{Votre compte est désactivé !}
      return false
    end
    true
  end

  def fb_user
    @fb_user ||= current_facebook_user && User.find_by_facebook_id( current_facebook_user.id )
  end

  protected

  def current_user
    @current_user ||= (login_from_session || login_from_basic_auth || login_from_cookie || fb_user ) unless @current_user == false
  end
end
