class DvdClubsController < AuthenticatedController
  before_filter      :must_be_member, :only => [:show]
  skip_before_filter :login_required, :only => :join
 
  make_resourceful do
    actions :all
  end
  
  # Override so as to take blacklist into account
#  def current_objects
#    @current_objects ||= 
#  end

  def new
    if Setting.get.can_add_club?
      @dvd_club = DvdClub.new
      @user_dvd_club = UserDvdClub.new(:pseudo => current_user.default_pseudo)
    else
      @cannot_add_club_msg = 'Désolé, il est temporairement impossible de créer un nouveau club.'
    end
  end

  def create
    before :create
    User.transaction do
      @dvd_club = DvdClub.new(params[:dvd_club])
      @dvd_club.owner = current_user
      @user_dvd_club = UserDvdClub.new(params[:user_dvd_club].merge(:user_id             => current_user.id, 
                                                                    :dvd_club_id         => @dvd_club.id, 
                                                                    :subscription_status => true))
      @dvd_club.save!
      @user_dvd_club.dvd_club = @dvd_club
      @user_dvd_club.save!
      redirect_to "/dvds/new" 
    end
  rescue
    @dvd_club.id = nil
    render :action => 'new'
  end
  
  def new_dvd
    @dvd_club = DvdClub.find(params[:dvd_club_id])  
  end
  
  def invite
    @dvd_club = DvdClub.find(params[:id])
    if params[:state] == 'done'
      render :action => 'invited'
    else
      unless Setting.get.can_add_user_to_club?( @dvd_club )
        @cannot_add_user_to_club_msg = %Q{Désolé, il est temporairement impossible d'ajouter de nouveaux membres au club "#{@dvd_club.name}".}
      end
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
      status = UserMailer.deliver_club_invitation(@dvd_club, params[:mail], join_url(token)) 
    end
    @redirect_url = dvd_clubs_path
    render :action => 'invited'
  end
  
  def join
    @password      = params[:password]
    @token         = params[:id]
    @invitation    = Invitation.find_by_token(@token)
    @user          = User.find_by_email(@invitation.email)
    @dvd_club      = @invitation.dvd_club
    @user_dvd_club = UserDvdClub.new(params[:user_dvd_club])
    @user_dvd_club.pseudo = @user if @user_dvd_club.blank?
    if request.post? 
      u = User.authenticate(@user.email, params[:password])
      if u
        self.current_user = u
        @user_dvd_club = UserDvdClub.new(params[:user_dvd_club].merge(:invited_by          => @invitation.user, 
                                                                      :user_id             => @user.id, 
                                                                      :dvd_club_id         => @dvd_club.id, 
                                                                      :subscription_status => true))
        redirect_to home_path and return if @user_dvd_club.save
      else
        flash.now[:notice] = "Mot de passe incorrect"
      end
    end
  end
  
  def blacklist
    @fellow_club_members = current_user.fellow_club_members
    if request.method == :post 
      blacklist_hash = params[:blacklisted]
      @fellow_club_members.each do |fcm|
        # N.B. lacklist! and whitelist! are double-submit-proof
        if blacklist_hash and blacklist_hash[fcm.id.to_s]
          current_user.blacklist!( fcm )
        else  
          current_user.whitelist!( fcm )
        end
      end
      # Reload from updated lists :
      @fellow_club_members = current_user.fellow_club_members
    end
  end
  
private
  def must_be_member
    redirect_to home_url unless UserDvdClub.membership(current_object, current_user)
  end
  
end
