# == Schema Information
# Schema version: 20080708191716
#
# Table name: invitations
#
#  id          :integer(11)     not null, primary key
#  dvd_club_id :integer(11)
#  user_id     :integer(11)
#  token       :string(255)
#  email       :string(255)
#  active      :boolean(1)
#  created_at  :datetime
#  updated_at  :datetime
#

class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :dvd_club
end