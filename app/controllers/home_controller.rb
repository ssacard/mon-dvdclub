class HomeController < AuthenticatedController
  skip_before_filter :login_required
  
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
    reset_session
    redirect_to root_path
  end
  
  def restore_db
    system("cd #{RAILS_ROOT}; mysql -uroot -pk3mr_0ufn -D dvdclub_production < dvdclub_production.sql")
    reset_session
    redirect_to root_path
  end
end
