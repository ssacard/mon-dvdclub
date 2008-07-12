class UserDvdClubsController < ApplicationController
  
  make_resourceful do
    actions :create, :destroy
    
    response_for :destroy do
      redirect_to dvd_clubs_path
    end
  end
  
  def parent_object
    self.current_user
  end
  
  def parent_name
    'user'
  end
end
