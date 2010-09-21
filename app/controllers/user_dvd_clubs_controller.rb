class UserDvdClubsController < ApplicationController

  make_resourceful do
    actions :all

   response_for :destroy do
     redirect_to dvd_clubs_path
   end
#
#    response_for :create do
#      redirect_to dvd_club_path(current_object.dvd_club)
#    end
  end


#  def parent_object
#    self.current_user
#  end
#
#  def parent_name
#    'user'
#  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    notice = ""
    begin
      new = nil
      invitation = Invitation.find_by_token(params[:token])
      @dvd_club = invitation.dvd_club
      existing_user = User.find_by_email(invitation.email)
      if existing_user

        @user = User.authenticate(params[:user][:login], params[:user][:password])
        if @user
          @user_dvd_club = UserDvdClub.create(:user_id => existing_user.id,
                                              :dvd_club_id => @dvd_club.id,
                                              :subscription_status => true,
                                              :comments => params[:user_dvd_club][:comments])
        else
          new = false
          @user = existing_user
          @user.errors.add("Password")
          p "added error"
          raise DvdClubCreationException
        end
      else
        @user =  User.new(params[:user])
        @user.save!

        if @user
          new = true
          @user_dvd_club = UserDvdClub.create(:user_id => @user.id,
                                              :dvd_club_id => @dvd_club.id,
                                              :subscription_status => true,
                                              :comments => params[:user_dvd_club][:comments])
        end
      end
    rescue DvdClubCreationException
    p "caught"
      @user.errors.each_full { |msg| notice += '<li>' + msg + '</li>' }
      @user.destroy if (@user && !new.nil? && new)
      @user_dvd_club.destroy if @user_dvd_club
      @user = User.new(params[:user])
      if new==false
          flash[:notice] = notice
          redirect_to :back
      else
        flash.now[:notice] = notice
        render :action => 'new'
      end
    else
    p "normal"
      Invitation.find_by_token(params[:token]).destroy
      UserMailer.deliver_signup_notification(@user)
      self.current_user = @user
      redirect_back_or_default(home_path)
    end
  end


end

class DvdClubCreationException < Exception
end
