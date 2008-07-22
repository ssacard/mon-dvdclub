class DvdClubsController < AuthenticatedController
  before_filter      :must_be_member, :only => [:show]
  skip_before_filter :login_required, :only => :join
  make_resourceful do
    actions :all
  end

  def create
    before :create
    begin
      @dvd_club = DvdClub.new(params[:dvd_club])
      @dvd_club.owner_id = self.current_user.id
      @dvd_club.save!
    rescue
      render :action => 'new'
    else
      self.current_user.dvd_clubs << @dvd_club
      redirect_to dvd_clubs_path
    end
  end
  
  def new_dvd
    @dvd_club = DvdClub.find(params[:dvd_club_id])  
  end
  
  def invite
    @dvd_club = DvdClub.find(params[:id])
    if params[:state] == 'done'
      render :action => 'invited'  
    else
      render :action => 'invite'
    end
  end

  def send_mails
    @dvd_club = DvdClub.find(params[:dvd_club_id])
    
    @recipients = params[:mail][:recipients].split(',')
    @recipients.each do |r|
      token = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{r}--")
      Invitation.create!(:user_id => self.current_user.id, 
                         :dvd_club_id => @dvd_club.id,
                         :token => token,
                         :active => true,
                         :email => r)
      status = UserMailer.deliver_club_invitation(@dvd_club, params[:mail], "/join/#{token}") 
    end
    render :action => 'invited'
  end
  
  def join
    @token      = params[:id]
    @invitation = Invitation.find_by_token(@token)
    @user       = User.find_by_email(@invitation.email)
    @dvd_club   = @invitation.dvd_club
    if request.post? 
      u = User.authenticate(@user.login, params[:password])
      if u
        self.current_user = u
        @user_dvd_club = UserDvdClub.create(:invited_by => @invitation.user, 
                                            :user_id => @user.id, 
                                            :dvd_club_id => @dvd_club.id, 
                                            :subscription_status => true)
        redirect_to home_path
      else
        flash.now[:notice] = "Mot de passe incorrect"
      end
    end
  end
  
private
  def must_be_member
    redirect_to home_url unless UserDvdClub.membership(current_object, current_user)
  end
  
end
