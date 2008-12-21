class Admin::DvdClubsController < ApplicationController

  make_resourceful do
    actions :all

    response_for :create, :update do |format|
      format.html { redirect_to admin_dvd_clubs_path }
    end
  end
  
  def info
    @dvd_club = DvdClub.find( params[:id] )
    @dvd_club_users = @dvd_club.users.collect {|u| u.email unless u == current_user }
  end

end
