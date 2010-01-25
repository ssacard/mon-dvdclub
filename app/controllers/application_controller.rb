class ApplicationController < ActionController::Base

  include AuthenticatedSystem
  helper :all
  protect_from_forgery

  allow :exec => :check_auth, :redirect_to => '/'

  def check_auth
    unless current_user.nil? or current_user.active?
      flash[:notice] = %{Votre compte est désactivé !}
      return false
   end
   true
  end

  private

end