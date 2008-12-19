# == Schema Information
# Schema version: 20080708191716
#
# Table name: users
#
#  id                        :integer(11)     not null, primary key
#  login                     :string(255)     
#  email                     :string(255)     
#  crypted_password          :string(40)      
#  salt                      :string(40)      
#  password_secret           :string(40)      
#  remember_token            :string(255)     
#  created_at                :datetime        
#  updated_at                :datetime        
#  accept_offers             :integer(3)      
#  remember_token_expires_at :datetime        
#  deleted_at                :datetime        
#

require 'digest/sha1'
class User < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  attr_accessor :password, :terms
  
  validates_presence_of     :email,:message => 'Email obligatoire'
  validates_presence_of     :password,                   :if => :password_required?,:message => 'Mot de passe obligatoire'
  
  # validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_length_of       :email,    :within => 3..100, :allow_blank => true
  validates_uniqueness_of   :email, :case_sensitive => false, :message => 'Cet email est déjà utilisé'
  validates_acceptance_of   :terms, :on => :create, :message => 'Vous devez accepter les conditions d\'utilisation'
  
  before_save :encrypt_password
  has_many :user_dvd_clubs
  has_many :dvd_clubs, :through => :user_dvd_clubs
  has_many :owned_dvds, :class_name => 'Dvd', :foreign_key => :owner_id
  has_many :owned_dvd_clubs, :class_name => 'DvdClub', :foreign_key => :owner_id
  has_many :waiting_lists
  has_many :dvds, :through => :waiting_lists
  has_many :booked_dvds, :class_name => 'Dvd', :foreign_key => 'booked_by'
  
  # Users that are members of at least one club in common with me
  def fellow_club_members
    fellows = []
    self.dvd_clubs.find( :all, :include => :users ).each {|c| c.users.each {|u| fellows << u } }
    fellows.uniq!
    fellows.delete self
    fellows.sort {|a,b| a.email <=> b.email }
    fellows
  end
  
  def on_my_blacklist?( user )
    # TODO : implement ???
    false
  end
  
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :password, :terms, :accept_offers

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(email, password)
    u = find_by_email(email) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
  
  has_and_belongs_to_many :roles do
    def include?(role)
      role_name = case 
        when role.respond_to?(:name) then role.name.downcase
        else role.to_s.downcase
      end
      
      count(:conditions => ["roles.name = ?", role_name]) != 0
    end
  end
  
  
  def pseudo(dvdclub)
    UserDvdClub.membership(dvdclub, self).pseudo
  end

  def default_pseudo 
    user_dvd_clubs.empty? ? '' : user_dvd_clubs.first.pseudo
  end
  
  def pseudo_for_user(user)
    pseudo(DvdClub.first_in_common(user, self))
  end
  
  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def is_admin?
    self.roles.detect {|r| r.name.to_sym == :admin} # .include?(:admin)
  end
  
  def request_password_reset
    token = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--")
    self.password_secret = token
    save
  end
  
  def pending_requests
    Dvd.awaiting_approval.all(:conditions => {:booked_by => id})
  end
  
  # List all DVDs belonging to the subscribed DVD clubs
  def dvds(options= {:order => 'created_at DESC', :limit => 5}, without_mydvds = false)
    #Dvd.all(:conditions => ['owner_id in (?) and state = ? and owner_id != ?', get_visible_user_ids, 'available', without_mydvds ? self.id : 0 ])
    Dvd.all(options.merge(:conditions => ['owner_id in (?) and state != ? && owner_id != ?', get_visible_user_ids, 'blocked', without_mydvds ? id : 0 ]))
  end

  def dvds_by_category(category)
    # Dvd.all(:conditions => ['owner_id in (?) and state = ? and dvd_category_id = ?', get_visible_user_ids, 'available', category.id ])
    Dvd.all(:conditions => ['owner_id in (?) and dvd_category_id = ?', get_visible_user_ids, category.id ])
  end
  
  def rubriques
    attributes = Array.new
    
    DvdCategory.find(:all).each do |c|
      category = Hash.new
      category[:rubrique] = c
      category[:count] = dvds_by_category(c).length
      attributes << category
    end
    attributes
  end
  
  def user_booked_dvds
    booked_dvds.select{|d| d.state == 'booked'}  
  end
  
  def avatar
    'user.jpg'
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
    # TODO : Send mail if necessary
  end
  
  def do_suspend
    # TODO : Send mail if necessary
  end
  
  def do_delete
    # TODO : Send mail if necessary
  end
  
  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    def email_required?
      !email.blank?
    end
    
    def get_visible_user_ids
      # Get club_id
      dvd_club_ids = user_dvd_clubs.map &:dvd_club_id
      # Get user from all this dvd_club
      dvd_club_user_ids = UserDvdClub.all(:conditions => ["dvd_club_id in (?)", dvd_club_ids], :select => "DISTINCT(user_id)").collect &:user_id
      
      # Get blocked users
      blocked_user_ids = BlockedUser.all(:conditions => {:blocked_user_id => id, :dvd_club_id => dvd_club_ids}).collect &:user_id
      
      dvd_club_user_ids - blocked_user_ids
    end
    
end
