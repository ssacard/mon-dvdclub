# == Schema Information
# Schema version: 20080708191716
#
# Table name: blocked_users
#
#  id              :integer(11)     not null, primary key
#  user_id         :integer(11)     
#  blocked_user_id :integer(11)     
#  created_at      :datetime        
#  updated_at      :datetime        
#

class BlockedUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :dvd_club
  belongs_to :blocked_user, :class_name => 'User'
end
