# == Schema Information
# Schema version: 20080708191716
#
# Table name: waiting_lists
#
#  id         :integer(11)     not null, primary key
#  user_id    :integer(11)
#  dvd_id     :integer(11)
#  created_at :datetime
#  updated_at :datetime
#

class WaitingList < ActiveRecord::Base
  belongs_to :user
  belongs_to :dvd
end