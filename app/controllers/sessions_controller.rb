# This controller handles the login/logout function of the site.
class SessionsController < AuthenticatedController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  skip_before_filter :login_required, :only => [ :new, :create, :logout_facebook ]

  # don't check auth, else we won't be able to logout if inactive
  def check_auth
    true
  end

  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:email], params[:password])
    if logged_in?
      if ! self.current_user.active?
        self.current_user.forget_me
        self.current_user = nil
        cookies.delete :auth_token
        reset_session
        flash[:notice] = "Login ou mot de passe incorrect"
        render :action => 'new'
        return
      end
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(home_path)
    else
      flash[:notice] = "Login ou mot de passe incorrect"
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.each do |cookie|
      cookies.delete cookie
    end
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(root_path)
  end

  def logout_facebook
    #clear_facebook_session_information
    self.current_user.forget_me
    reset_session
    redirect_to root_path
  end
end
