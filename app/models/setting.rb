class Setting < ActiveRecord::Base
  
  def self.get
    Setting.first or Setting.create
  end
  
  def can_add_club?
    ( c = Setting.get.max_clubs ).nil? or c == 0 or DvdClub.count < c
  end

  def can_add_user_to_club?( club )
    ( c = Setting.get.max_club_members ).nil? or c == 0 or club.users.count < c
  end
  
end
