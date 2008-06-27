class UserDvdClubsController < ApplicationController
  
  make_resourceful do
    actions :create, :destroy
  end
  
  def parent_object
    self.current_user
  end
  
  def parent_name
    'user'
  end
end
