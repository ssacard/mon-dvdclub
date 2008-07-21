class UserDvdClubsController < ApplicationController
  
  make_resourceful do
    actions :all
    
#    response_for :destroy do
#      redirect_to dvd_club_path(current_object.dvd_club)
#    end
#    
#    response_for :create do
#      redirect_to dvd_club_path(current_object.dvd_club)
#    end
  end
  
  
#  def parent_object
#    self.current_user
#  end
#  
#  def parent_name
#    'user'
#  end

  
end
