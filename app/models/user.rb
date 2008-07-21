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
  
  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  validates_confirmation_of :email
  validates_acceptance_of   :terms, :on => :create
  
  before_save :encrypt_password
  has_many :user_dvd_clubs
  has_many :dvd_clubs, :through => :user_dvd_clubs
  has_many :owned_dvds, :class_name => 'Dvd', :foreign_key => :owner_id
  has_many :owned_dvd_clubs, :class_name => 'DvdClub', :foreign_key => :owner_id
  has_many :waiting_lists
  has_many :dvds, :through => :waiting_lists
  has_many :booked_dvds, :class_name => 'Dvd', :foreign_key => 'booked_by'
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :email_confirmation, :terms, :accept_offers

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
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
    self.roles.include?(:admin)
  end
  
  def request_password_reset
    token = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--")
    self.password_secret = token
    save
  end
  
  # List all DVDs belonging to the subscribed DVD clubs
  # Using 2 sql queries approach to avoid the n+1 sql queries problem
  
  def dvds(without_mydvds = false)
    dvd_club_ids = dvd_clubs.collect{|c| c.id}
    Dvd.all(:conditions => ['dvd_club_id in (?) and state != ? and owner_id != ?', dvd_club_ids, 'hidden', without_mydvds ? self.id : 0])
  end

  # List all DvdCategories belonging to the subscribed DVD clubs
  # Using 2 sql queries approach to avoid the n+1 sql queries problem
  
  def dvd_categories
    dvd_category_ids = User.find_by_sql("select dvd_club.id from users user, user_dvd_clubs user_dvd_club, dvd_clubs dvd_club, dvd_categories dvd_category, dvds dvd   
                                   where user.id=#{self.id} AND user.id=user_dvd_club.user_id 
                                   AND user_dvd_club.dvd_club_id=dvd_club.id 
                                   AND dvd.dvd_club_id=dvd_club.id 
                                   AND dvd.state != 'hidden'
                                   AND dvd.owner_id != #{self.id}
                                   AND dvd.dvd_category_id=dvd_category.id").collect{|c| c.id}                             
    DvdCategory.find(dvd_category_ids) rescue []   
  end

  # List all DvdCategories belonging to the subscribed DVD clubs
  # Using 2 sql queries approach to avoid the n+1 sql queries problem
  
  def dvds_by_category(category)
    Dvd.find_by_sql("select dvd.* from users user, user_dvd_clubs user_dvd_club, dvd_clubs dvd_club, dvds dvd
                                where user.id=#{self.id} 
                                AND user.id=user_dvd_club.user_id 
                                AND user_dvd_club.dvd_club_id=dvd_club.id 
                                AND dvd_club.id=dvd.dvd_club_id
                                AND dvd.dvd_category_id=#{category.id}")
        
    rescue
    []
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
    booked_dvds.select{|d| d.state=='booked'}  
  end
  
  def avatar
    'user.jpg'
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
    
end
