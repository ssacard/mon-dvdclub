# == Schema Information
# Schema version: 20080708191716
#
# Table name: user_dvd_clubs
#
#  id                  :integer(11)     not null, primary key
#  dvd_club_id         :integer(11)     
#  user_id             :integer(11)     
#  subscription_status :boolean(1)      
#  created_at          :datetime        
#  updated_at          :datetime        
#

class UserDvdClub < ActiveRecord::Base
  belongs_to :user
  belongs_to :dvd_club
end
