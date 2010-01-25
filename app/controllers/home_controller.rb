class HomeController < AuthenticatedController
  skip_before_filter :login_required, :only => [:reset_db, :restore_db]

  def index
    @dvds = current_user.dvds
  end

  def dvds
    @dvds = current_user.owned_dvds
  end

  def requests
    @dvds       = current_user.booked_dvds.booked
    @given_dvds = current_user.owned_dvds.booked
  end

  def pendings
    @dvds         = current_user.owned_dvds.awaiting_approval
    @pending_dvds = current_user.pending_requests
  end
end