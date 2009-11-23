module MenuHelper
  
  # Count the number of actions needed for the red box near the "demande en cours" tab
  def actions_needed
    awaiting_approval = current_user.owned_dvds.awaiting_approval
    pending_requests = current_user.pending_requests
    awaiting_approval.count + pending_requests.count
  end
  
end