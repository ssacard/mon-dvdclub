class HomeController < AuthenticatedController
  skip_before_filter :login_required, :only => [:reset_db, :restore_db]
  
  def index
    @dvds = current_user.dvds
  end
  
  def dvds
    @dvds = current_user.owned_dvds
  end
  
  def requests
    @dvds = current_user.booked_dvds.booked
    @given_dvds = current_user.owned_dvds.booked
  end

  def pendings
    @dvds = current_user.owned_dvds.awaiting_approval
    @pending_dvds = current_user.pending_requests
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
