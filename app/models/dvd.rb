class Dvd < ActiveRecord::Base
	has_and_belongs_to_many :directors
	has_and_belongs_to_many :manufacturers, :join_table => 'manufacturers_dvds'
	has_and_belongs_to_many :actors, :join_table => 'dvds_actors'
	validates_presence_of :title
  belongs_to :dvd_club
  belongs_to :dvd_format
  belongs_to :dvd_category
  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id
  has_many :waiting_lists
  belongs_to :booked_by_user, :class_name => 'User', :foreign_key => 'booked_by'
  has_many :users, :through => :waiting_lists
  acts_as_state_machine :initial => :available
  
  state :available
  state :approval
  state :booked
    
  event :request do
    transitions :from => :available, :to => :approval
  end
  event :register do
    transitions :from => :approval, :to => :booked  
  end
  
  event :cancel_request do
    transitions :from => :approval, :to => :available
  end
  
  event :unregister do
    transitions :from => :booked, :to => :available
  end
  
  event :book do
    transitions :from => :available, :to => :booked
    transitions :from  => :approval, :to => :booked
  end
  
  def self.create_record(attrs)
    dvd = Dvd.create!(:asin => attrs['asin'], 
    :details_url => attrs['url'], 
    :title => attrs['title'],
    :dvd_club_id => attrs[:dvd_club_id],
    :owner_id => attrs[:owner_id],
    :dvd_category_id => attrs[:dvd][:dvd_category_id])
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
    end
    dvd
    rescue
      false 
  end

end
