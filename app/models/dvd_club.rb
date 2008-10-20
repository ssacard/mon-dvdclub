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
  has_many :user_dvd_clubs
  has_many :users, :through => :user_dvd_clubs
  has_many :recent_users, :through => :user_dvd_clubs
  
  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id
  validates_presence_of :name,  :message => 'Vous devez donner un nom votre club'
  validates_presence_of :description,  :message => 'Vous devez donner une description votre club'
  validates_presence_of :owner_id, :message => ''
  validates_presence_of :club_topic_id, :message =>  'Vous devez choisir un type de club'
  validates_acceptance_of   :terms

  def recent_users(date = 1.week.ago)
    users.all :conditions => ["user_dvd_clubs.created_at > ?", date]
  end
  
  def has_member?(user)
    user_dvd_clubs.first :conditions => {:dvd_club_id => self.id, :user_id => user.id}
  end
  
  def self.first_in_common(user1, user2)
    dvd_clubs = user1.dvd_clubs & user2.dvd_clubs
    dvd_clubs.first
  end

  def dvds(exclude_user = nil)
    dvd_club_user_ids = self.user_dvd_clubs.collect{|c| c.user_id}
    Dvd.all(:conditions => ['owner_id in (?) and state != ? and owner_id != ?', dvd_club_user_ids, 'hidden', exclude_user.nil? ? 0 : exclude_user.id])    
  end
end
