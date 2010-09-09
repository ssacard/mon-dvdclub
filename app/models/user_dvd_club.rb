# -*- coding: utf-8 -*-
# == Schema Information
# Schema version: 20080708191716
#
# Table name: user_dvd_clubs
#
#  id                  :integer(11)     not null, primary key
#  dvd_club_id         :integer(11)
#  user_id             :integer(11)
#  pseudo              :string(255)
#  description         :string(255)
#  subscription_status :boolean(1)
#  created_at          :datetime
#  updated_at          :datetime
#  comments            :text
#  invited_by_id       :integer(11)
#

class UserDvdClub < ActiveRecord::Base
  belongs_to :user
  belongs_to :dvd_club
  belongs_to :invited_by, :class_name => 'User'
  validates_uniqueness_of :pseudo, :scope => :dvd_club_id, :message => 'Ce pseudo existe déjà dans ce DVD club'

  def self.membership(dvd_club, user)
    first :conditions => ["user_id=? AND dvd_club_id=?", user.id, dvd_club.id]
  end
end
