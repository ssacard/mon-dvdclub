class DvdClubsController < ApplicationController
  make_resourceful do
    actions :all
    belongs_to :user
  end
  
  def parent_object
    
  end
end
