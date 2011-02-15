# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  AppSecretFacebook = 'f182ee8dcb0e50247f9f90cc0bb4ed19'

  include AuthenticatedSystem
  helper :all
  before_filter :set_facebook_session
  helper_method :facebook_session

  protect_from_forgery :except => [ :facebook_create ]

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

  protected

  def current_user
    @current_user ||= (login_from_session || login_from_basic_auth || login_from_cookie || login_from_fb ) unless @current_user == false
  end

  def login_from_fb
    if facebook_session
      self.current_user = User.find_by_facebook_id(facebook_session.user.uid )
    end
  end

  private

end
