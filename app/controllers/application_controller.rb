# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base

  include AuthenticatedSystem
  helper :all
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

  private

end
