# == Schema Information
# Schema version: 20080708191716
#
# Table name: club_topics
#
#  id   :integer(11)     not null, primary key
#  name :string(255)
#

class ClubTopic < ActiveRecord::Base
  has_many :dvd_clubs
end