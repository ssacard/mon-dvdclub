class DvdClubsController < AuthenticatedController
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
end
