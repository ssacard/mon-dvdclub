class HomeController < AuthenticatedController
  def index
    @dvds = self.current_user.dvds.select{|d| d.available?}  
  end
  
  def dvds
    @dvds = self.current_user.owned_dvds
  end
  
  def demands
    @dvds = self.current_user.booked_dvds
  end
  
  def reset_db
    system("cd #{RAILS_ROOT}; RAILS_ENV=#{ENV['RAILS_ENV']} rake dvdclub:app:reset")
    render :text => 'Reset done!!'
  end
  
  def restore_db
    system("cd #{RAILS_ROOT}; mysql -uroot -pk3mr_0ufn -D dvdclub_production < dvdclub_production.sql")
    render :text => 'Restore done!!'
  end
end
