class Blacklisting < ActiveRecord::Base

  belongs_to :user
  belongs_to :user_target, :class_name => 'User', :foreign_key => 'user_id_target'
  validates_presence_of :user, :user_target

  def self.blacklist!( blacklister, target )
    if blacklisting = Blacklisting.find(:first, :conditions => ['(user_id = ? AND user_id_target = ?) OR (user_id = ? AND user_id_target = ?)',blacklister, target, target, blacklister] )
      if blacklisting.user == blacklister
        if blacklisting.source_forgot
          blacklisting.source_forgot = false
          blacklisting.save
        end
      else
        if blacklisting.target_forgot
          blacklisting.target_forgot = false
          blacklisting.save
        end
      end
    else
      Blacklisting.create( :user => blacklister, :user_target => target )
    end
  end
  
  def self.whitelist!( whitelister, target )
    if blacklisting = Blacklisting.find(:first, :conditions => ['(user_id = ? AND user_id_target = ?) OR (user_id = ? AND user_id_target = ?)',whitelister, target, target, whitelister] )
      if blacklisting.user == whitelister
        if blacklisting.target_forgot
          blacklisting.destroy # Both sides want to see each other again
        else
          unless blacklisting.source_forgot
            blacklisting.source_forgot = true
            blacklisting.save
          end
        end
      else  
        if blacklisting.source_forgot
          blacklisting.destroy # Both sides want to see each other again
        else
          unless blacklisting.target_forgot
            blacklisting.target_forgot = true
            blacklisting.save
          end
        end
      end
    end
  end
    
end
