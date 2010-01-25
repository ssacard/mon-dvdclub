module MenuHelper

  # Count the number of actions needed for the red box near the "demande en cours" tab
  def actions_needed
    current_user.owned_dvds.awaiting_approval.count + current_user.pending_requests.count
  end

end