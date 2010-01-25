class PublicController < ApplicationController

  allow :index, :exec => :check_auth

  def check_auth
    true
  end


  def index
  end

  def join_club
    @invitation = Invitation.find_by_token(params[:token])
    @user = User.new
    @dvd_club = @invitation.dvd_club
  end
end