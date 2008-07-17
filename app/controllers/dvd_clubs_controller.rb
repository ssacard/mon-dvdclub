class DvdClubsController < AuthenticatedController
  before_filter :must_be_member, :only => [:show]
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
      notice = ""
      @dvd_club.errors.each_full{|msg| notice += '<li>' + msg + '</li>'}
      flash[:notice] = notice
      redirect_to new_dvd_club_path
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
    status = UserMailer.deliver_club_invitation(@dvd_club, params[:mail], join_dvd_club_url(@dvd_club))       
    
    @recipients = params[:mail][:recipients].split(',')
    render :action => 'invited'
  end
  
  def join
    session[:dvd_club_id] = params[:id]
    redirect_to register_url
  end
  
private
  def must_be_member
    redirect_to home_url unless UserDvdClub.membership(current_object, current_user)
  end
  
end
