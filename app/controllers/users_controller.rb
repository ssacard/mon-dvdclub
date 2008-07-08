class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    notice = ""
    begin
      @user = User.new(params[:user])
      @user.save!
      if @user
        @dvd_club = @user.owned_dvd_clubs.new(params[:dvd_club])
        @dvd_club.save!
        @user_dvd_club = UserDvdClub.create(:user_id => @user.id, :dvd_club_id => @dvd_club.id, :subscription_status => true)
      end
    rescue
      @user.errors.each_full { |msg| notice += '<li>' + msg + '</li>' }
      @dvd_club.errors.each_full { |msg| notice += '<li>' + msg + '</li>' } if @dvd_club
      @user.destroy if @user
      @dvd_club.destroy if @dvd_club
      @user_dvd_club.destroy if @user_dvd_club
      flash[:notice] = notice
      render :action => 'new'    
    else
      UserMailer.deliver_signup_notification(@user)
      self.current_user = @user
      redirect_to('/home')
    end
  end

  def forgot_password
    begin
      if request.post?
        @user = User.find_by_email(params[:user][:email])
        @user.request_password_reset
        UserMailer.deliver_request_password_change(@user)
        flash[:notice] ="A link is sent to your email address"
        redirect_to('/reset_request_done')
      end
    rescue
      flash[:notice] = "Invalid Email"
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
  end
  
  def update
  end
  
end

class UserNotFoundException < Exception  
end
