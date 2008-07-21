# == Schema Information
# Schema version: 20080708191716
#
# Table name: dvd_clubs
#
#  id            :integer(11)     not null, primary key
#  club_topic_id :integer(11)     
#  name          :string(255)     
#  description   :text            
#  created_at    :datetime        
#  updated_at    :datetime        
#  owner_id      :integer(10)     
#

class DvdClub < ActiveRecord::Base
  attr_accessor :terms
  belongs_to :club_topic
  has_many :dvds
  has_many :user_dvd_clubs
  has_many :users, :through => :user_dvd_clubs
  has_many :recent_users, :through => :user_dvd_clubs
  
  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id
  validates_presence_of :name, :description, :owner_id, :club_topic_id
  validates_acceptance_of   :terms

  def recent_users(date = 1.week.ago)
    users.all :conditions => ["user_dvd_clubs.created_at > ?", date]
  end
  
  def has_member?(user)
    user_dvd_clubs.first :conditions => {:dvd_club_id => self.id, :user_id => user.id}
  end
  
  def self.in_common(user1, user2, name_only = true)
    dvd_clubs = user1.dvd_clubs & user2.dvd_clubs
    name_only ? '(DVD Club: ' + dvd_clubs.map(&:name).join(' - ') + ')' : dvd_clubs
  end
  
end
