class Blacklisting < ActiveRecord::Base

  belongs_to :user
  belongs_to :user_target, :class_name => 'User', :foreign_key => 'user_id_target'
  validates_presence_of :user, :user_target

  def self.blacklist!( blacklister, target )
    # Are we on each-other's blacklist (either way) ?
    if blacklisting = Blacklisting.find(:first, :conditions => ['(user_id = ? AND user_id_target = ?) OR (user_id = ? AND user_id_target = ?)',blacklister, target, target, blacklister] )
      if blacklisting.user == blacklister     # I blacklisted you first
                                              # In case I un-blacklisted you
        if ( f = blacklisting.source_forgot ).nil? or f == true
          blacklisting.source_forgot = false  # I blacklist you anew !
          blacklisting.save
        end
      else                                    # You blaklisted me first
                                              # In case you un-blacklisted me
        if ( f = blacklisting.target_forgot ).nil? or f == true
          blacklisting.target_forgot = false  # You blacklist me anew (bastard !)
          blacklisting.save
        end
      end
    else # I shoot first
      Blacklisting.create( :user => blacklister, :user_target => target )
    end
  end

  def self.whitelist!( whitelister, target )
    # Are we on each-other's blacklist (either way) ?
    if blacklisting = Blacklisting.find(:first, :conditions => ['(user_id = ? AND user_id_target = ?) OR (user_id = ? AND user_id_target = ?)',whitelister, target, target, whitelister] )
      if blacklisting.user == whitelister     # I blacklisted you first,
                                              # You have already un-blacklisted me,
        if ( f = blacklisting.target_forgot ).nil? or f == true
          blacklisting.destroy                # We both want to see each other again.
        else
                                              # I have not un-blacklisted you yet,
          unless ( f = blacklisting.source_forgot ).nil? or f == true
            blacklisting.source_forgot = true # I un-blackliste you now (if you do the same blacklisting will vanish).
            blacklisting.save
          end                                 # Othetwise there's nothing more I can do.
        end
      else                                    # You blaklisted me first,
                                              # I have already un-blacklisted you,
        if ( f = blacklisting.source_forgot ).nil? or f == true
          blacklisting.destroy                # We both want to see each other again.
        else
                                              # You have not un-blacklisted me yet,
          unless ( f = blacklisting.target_forgot ).nil? or f == true
            blacklisting.target_forgot = true # You un-blackliste me now (if I do the same blacklisting will vanish).
            blacklisting.save
          end                                 # Othetwise there's nothing more you can do.
        end
      end
    end
  end

end