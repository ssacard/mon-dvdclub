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

  before_destroy :invalidate_sharing_through_this_club

  def self.membership(dvd_club, user)
    first :conditions => ["user_id=? AND dvd_club_id=?", user.id, dvd_club.id]
  end

  private
  def invalidate_sharing_through_this_club
    user_dvds = Dvd.booked_by user.id
    user_dvds.each do |dvd|
      if is_single_link? dvd
        dvd.cancel_request! if dvd.approval?
        dvd.unregister! if dvd.booked?
      end
    end
    user.dvds.each do |dvd|
      if dvd.approval? or dvd.booked?
        if is_single_link? dvd
          dvd.cancel_request! if dvd.approval?
          dvd.unregister! if dvd.booked?
        end
      end
    end
  end
  def is_single_link?(dvd)
    common_clubs = ( dvd.owner.dvd_clubs & user.dvd_clubs )
    return ( common_clubs.size == 1 ) && common_clubs[0] == self.dvd_club
  end
      
end
