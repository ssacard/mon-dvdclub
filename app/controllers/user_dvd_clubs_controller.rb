class UserDvdClubsController < ApplicationController
  
  make_resourceful do
    belongs_to :user
    actions :create, :destroy
  end
  
end
