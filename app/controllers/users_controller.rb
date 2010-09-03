class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  before_filter :login_required, :only => [:edit, :udpate]

  # render new.rhtml
  def new
    @token         = params[:token]
    @invitation    = @token ? Invitation.find_by_token(@token) : nil
    email          = @invitation.email rescue nil
    @user          = (User.find_by_email(email) rescue nil) || User.new(:email => email)
    @dvd_club      = @invitation ? @invitation.dvd_club : DvdClub.new
    @user_dvd_club = UserDvdClub.new

    # Connot join twice a club
    redirect_to home_path and return if (@dvd_club.users.include? @user)
    render :template => (@user.new_record? ? 'users/new' : 'dvd_clubs/join')
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @token      = params[:token]
    @invitation = @token ? Invitation.find_by_token(@token) : nil
    @dvd_club   = @invitation ? @invitation.dvd_club : DvdClub.new(params[:dvd_club])
    ## TODO HACKALERT
    params[:user][:password_confirmation] = params[:user][:password]
    params[:user][:login] = params[:user][:email]
    @user       = User.new(params[:user])
    User.transaction do
      valid = @user.save
      if @dvd_club.new_record?
        @dvd_club = @user.owned_dvd_clubs.new(params[:dvd_club])
        valid = @dvd_club.save && valid
      end
      @user_dvd_club = UserDvdClub.new(params[:user_dvd_club].merge(:invited_by          => (@invitation.user rescue nil),
                                                                    :user_id             => @user.id,
                                                                    :dvd_club_id         => @dvd_club.id,
                                                                    :subscription_status => true))
      valid = @user_dvd_club.save && valid
      throw Exception unless valid
      session[:token] = nil
      UserMailer.deliver_signup_notification(@user, login_url)
      self.current_user = @user
      redirect_to(home_path)
   end
  rescue
    unless @user.new_record?
      @user.destroy
      @user = User.new(params[:user])
    end
   #@user       = User.new(params[:user])
   render :action => 'new'
  end

  def forgot_password
    begin
      if request.post?
        @user = User.find_by_email(params[:user][:email])
        @user.request_password_reset
        UserMailer.deliver_request_password_change(@user, change_password_url(@user.password_secret))
        flash[:notice] ="Un email vient de vous être envoyer avec un lien pour vous permettre de changer votre mot de passe."
        redirect_to('/reset_request_done')
      end
    rescue
      flash[:notice] = "Email non valide"
      render :action => 'forgot_password'
    end
  end

  def reset_request_done
  end

  def change_password
    begin
      @user = User.find_by_password_secret(params[:secret])
      raise UserNotFoundException unless @user
      if request.post?
        if @user.update_attributes(params[:user]) && !params[:user][:password].blank?
          flash[:notice] = "Password changed successfully"
          redirect_to new_session_path
        else
          notice =""
          @user.errors.each_full { |msg| notice += '<li>' + msg + '</li>' }
          flash[:notice] = notice == "" ? "Enter new password:" : notice
          redirect_to("/change_password/#{@user.password_secret}")
        end
      end
    rescue UserNotFoundException => e
      flash[:notice] = "Invalid URL"
      redirect_to('/')
    end
  end

  def edit
    @user = current_user
    # @user.email_confirmation = @user.email
  end

  def update
    @user = current_user
    if current_user.update_attributes params[:user]
      flash[:notice] = "Mise à jour éffectué"
      redirect_to settings_path
    else
      render :action => 'edit'
    end
  end

end

class UserNotFoundException < Exception
end