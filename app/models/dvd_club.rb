class DvdClub < ActiveRecord::Base
  belongs_to :club_topic
  has_many :dvds
  has_many :user_dvd_clubs
  has_many :users, :through => :dvd_clubs
  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id
  validates_presence_of :name, :description, :owner_id #, :club_topic_id
end
