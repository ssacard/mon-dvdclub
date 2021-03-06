# == Schema Information
# Schema version: 20080708191716
#
# Table name: dvd_clubs
#
#  id            :integer(11)     not null, primary key
#  name          :string(255)
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#  owner_id      :integer(10)
#

class DvdClub < ActiveRecord::Base
  attr_accessor :terms
  has_many :user_dvd_clubs
  has_many :users, :through => :user_dvd_clubs
  has_many :recent_users, :through => :user_dvd_clubs

  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id
  validates_presence_of :name,  :message => 'Vous devez donner un nom votre club'
  validates_presence_of :owner_id, :message => ''
  validates_acceptance_of   :terms, :on => :create, :message => 'Vous devez accepter les conditions d\'utilisation'

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

  def dvds(exclude_user = nil, blacklister = nil)
    # TODO : my guess is that exclude_user correspond to a first attemps at blacklisting
    # users. To stay on the safe side I coded around it (P.Lachaise - 23/12/08)
    if blacklister and ( blacklist = blacklister.blind_users )
      dvd_club_user_ids = self.user_dvd_clubs.collect do |c|
        c.user_id unless blacklist.detect {|user| user.id == c.user_id }
      end
    else
      dvd_club_user_ids = self.user_dvd_clubs.collect{|c| c.user_id}
    end
    Dvd.all(:conditions => ['owner_id in (?) and state != ? and owner_id != ?', dvd_club_user_ids, 'hidden', exclude_user.nil? ? 0 : exclude_user.id])
  end

  acts_as_state_machine :initial => :active
  state :active   , :enter => :do_activate
  state :suspended, :enter => :do_suspend
  state :deleted,   :enter => :do_delete

  event :activate do
    transitions :to => :active, :from => :suspended
  end

  event :suspend do
    transitions :to => :suspended, :from => :active
  end

  event :delete do
    transitions :to => :deleted, :from => [:active, :suspended]
  end

  def do_activate
    # TODO : Send mail to owner if necessary
  end

  def do_suspend
    # TODO : Send mail to owner if necessary
  end

  def do_delete
    # TODO : Send mail to owner if necessary
  end

end
