class UserDvdClubsController < ApplicationController
  
  make_resourceful do
    actions :all
    
#    response_for :destroy do
#      redirect_to dvd_club_path(current_object.dvd_club)
#    end
#    
#    response_for :create do
#      redirect_to dvd_club_path(current_object.dvd_club)
#    end
    
  end
  
  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    notice = ""
    begin
      invitation = Invitation.find_by_token(params[:token])
      @dvd_club = invitation.dvd_club
      @user = User.new(params[:user])      
      @user.save!
      if @user
        @user_dvd_club = UserDvdClub.create(:user_id => @user.id, :dvd_club_id => @dvd_club.id, :subscription_status => true)
      end
    rescue
      @user.errors.each_full { |msg| notice += '<li>' + msg + '</li>' }
      @user.destroy if @user
      @user_dvd_club.destroy if @user_dvd_club
      @user = User.new(params[:user])      
      flash.now[:notice] = notice
      render :action => 'new'    
    else
      UserMailer.deliver_signup_notification(@user)
      self.current_user = @user
      redirect_back_or_default(home_path)
    end
  end
  
#  def parent_object
#    self.current_user
#  end
#  
#  def parent_name
#    'user'
#  end

  
end
