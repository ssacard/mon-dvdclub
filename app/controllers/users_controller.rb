class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  before_filter :login_required, :only => [:edit, :udpate]

  # render new.rhtml
  def new
    @token      = params[:token]
    @invitation = @token ? Invitation.find_by_token(@token) : nil
    @user       = (User.find_by_email(@invitation.email) rescue nil) || User.new  
    @dvd_club   = @invitation ? @invitation.dvd_club : DvdClub.new
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
    @user       = User.new(params[:user])      
    begin
      @user.save!
      if @user
        if @dvd_club.new_record?
          @dvd_club = @user.owned_dvd_clubs.new(params[:dvd_club])
          @dvd_club.save!
        end
        @user_dvd_club = UserDvdClub.create(:user_id => @user.id, :dvd_club_id => @dvd_club.id, :subscription_status => true)
      end
    rescue
      @user.destroy if @user
      @dvd_club.destroy if @dvd_club && !@token 
      @user_dvd_club.destroy if @user_dvd_club
      render :action => 'new'    
    else
      session[:token] = nil
      UserMailer.deliver_signup_notification(@user)
      self.current_user = @user
      redirect_back_or_default(home_path)
    end
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
        if @user.update_attributes(params[:user]) && !params[:user][:password].blank? && !params[:user][:password_confirmation].blank?
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
    @user.email_confirmation = @user.email
  end
  
  def update
    token = params[:token]
    if token
      invitation = Invitation.find_by_token(token)
      @user = User.find_by_email(invitation.email)
      user = User.authenticate(params[:user][:login], params[:user][:password])
      if user
        UserDvdClub.create(:user_id => user.id, :dvd_club_id => invitation.dvd_club.id, :subscription_status => true)
        self.current_user = user
        redirect_to '/home'
      else
         flash[:notice] = "Invalid Username or Password"
        redirect_to :back
      end
    else
      @user = current_user
      if current_user.update_attributes params[:user]
        flash[:notice] = "Mise à jour éffectué"
        
        redirect_to '/home'
      else
        notice = ""
        @user.errors.each_full { |msg| notice += '<li>' + msg + '</li>' }
        flash.now[:notice] = "<ul>#{notice}</ul>"
        render :action => 'edit'
      end    
    end

  end
  
end

class UserNotFoundException < Exception  
end
