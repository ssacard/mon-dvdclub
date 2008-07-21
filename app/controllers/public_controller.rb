class PublicController < ApplicationController
  
  def index
  end
  
  def join_club
    @invitation = Invitation.find_by_token(params[:token])
  end
end
