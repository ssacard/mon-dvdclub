# == Schema Information
# Schema version: 20080708191716
#
# Table name: dvds
#
#  id              :integer(11)     not null, primary key
#  dvd_category_id :integer(11)
#  format_id       :integer(11)
#  asin            :string(255)
#  details_url     :text
#  created_at      :datetime
#  owner_id        :integer(10)
#  title           :string(255)
#  smallimage      :string(255)
#  largeimage      :string(255)
#  description     :text
#  state           :string(255)
#  booked_by       :integer(11)
#  booked_at       :datetime
#

class Dvd < ActiveRecord::Base

  has_and_belongs_to_many :directors
  has_and_belongs_to_many :manufacturers, :join_table => 'manufacturers_dvds'
  has_and_belongs_to_many :actors, :join_table => 'dvds_actors'

  validates_presence_of :title

  belongs_to :dvd_club
  belongs_to :dvd_format, :foreign_key => 'format_id'
  belongs_to :dvd_category
  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id
  has_many :waiting_lists
  belongs_to :booked_by_user, :class_name => 'User', :foreign_key => 'booked_by'
  has_many :users, :through => :waiting_lists
  acts_as_state_machine :initial => :available

  named_scope :booked,             :conditions => {:state => 'booked'}
  named_scope :awaiting_approval,  :conditions => {:state => 'approval'}
  named_scope :available,          :conditions => {:state => 'available'}
  named_scope :visible,            :conditions => ['state != ?', 'blocked']
  named_scope :whitelist, lambda { |user| { :conditions => "owner_id NOT IN (#{user.blind_users.collect {|u| u.id}.join(',')})" } }
  named_scope :booked_by, lambda { |user| { :conditions => { :booked_by => user } } }


  ## STATE MACHINE ###########################################
  state :available
  state :approval
  state :booked
  state :blocked

  # A user asked for getting this DVD
  event :request do
    transitions :from => :available, :to => :approval
  end

  # The request for getting this DVD has been accepted
  event :register do
    transitions :from => :approval, :to => :booked
  end

  # The request for getting this DVD has been refused
  event :cancel_request do
    transitions :from => :approval, :to => :available
  end

  # This dvd is not booked anymore
  event :unregister do
    transitions :from => :booked, :to => :available
  end

  # Block/Unblocked
  event :block do
    transitions :from => :available, :to => :blocked
  end

  event :unblock do
    transitions :from => :blocked, :to => :available
  end

  def self.create_record(attrs)
    dvd = Dvd.create!(:asin => attrs['asin'],
      :details_url     => attrs['url'],
      :title           => attrs['title'],
      :description     => attrs['description'],
      :smallimage      => attrs['smallimage'],
      :format_id       => ( attrs['dvd'] ? attrs['dvd']['format_id'] : (DvdFormat.find_by_name(attrs['format']).id rescue nil) ),
      :largeimage      => attrs['largeimage'],
      :owner_id        => attrs[:owner_id],
      :dvd_category_id => ( attrs['dvd'] ? attrs['dvd']['dvd_category_id'] : (DvdCategory.find_by_name(attrs['dvd_category_id']).id rescue nil)) )
    if attrs['manufacturer']
      manufacturer = Manufacturer.find_or_create_by_name(attrs['manufacturer'])
      dvd.manufacturers << manufacturer
    end
    if attrs['director']
      director     = Director.find_or_create_by_name(attrs['director'])
      dvd.directors     << director
    end

    attrs["actors"].each do |actor|
      a = Actor.find_or_create_by_name(actor)
      dvd.actors << a
    end unless attrs["actors"].blank?
    dvd
    # rescue
    #   false
  end

  def format_name
    dvd_format.name rescue "non précisé"
  end

end