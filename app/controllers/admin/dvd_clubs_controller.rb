class Admin::DvdClubsController < ApplicationController

  make_resourceful do
    actions :all

    response_for :create, :update do |format|
      format.html { redirect_to admin_dvd_clubs_path }
    end
  end

end
