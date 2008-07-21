class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :dvd_club
end
