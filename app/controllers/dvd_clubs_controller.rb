class DvdClubsController < ApplicationController
  make_resourceful do
    actions :all
    belongs_to :club_topic
  end
end
