class AdminController < AuthenticatedController
  # use base_auth to restrict access to admin actions
  allow :user => :is_admin?

  # m_r appends 'admin_' to the url_helpers
  def url_helper_prefix
    'admin_'
  end

  def index
  end

end