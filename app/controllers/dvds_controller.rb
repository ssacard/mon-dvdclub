class DvdsController < AuthenticatedController
  
  # TODO
  # Use make_resourceful and move these functions in hookup calls
  
  def search
    session[:search_title] = params[:title] if params[:title];
    @res = AmazonStore.search(session[:search_title], params[:page])
    render :update do |page|
      page.replace_html 'search-results', :partial => 'search_results', :locals => {:dvd_club_id => params[:dvd_club_id]}
    end
  end

  def new
    
  end

  def request_register
    @dvd = Dvd.find(params[:dvd_id])
  end
  
  def request_unregister
  end
  
  def register
    @dvd = Dvd.find(params[:dvd_id])
    @dvd.update_attributes!(:booked_by => self.current_user.id)
    @dvd.request!
    UserMailer.deliver_dvd_request(@dvd, self.current_user,
                                   url_for(:controller => :dvds, :action => :approve, :id => @dvd.id),
                                   url_for(:controller => :dvds, :action => :refuse, :id => @dvd.id));
  end
  
  def unregister
    dvd = Dvd.find(params[:id])
    dvd.unregister!
  end
  
  def create
    dvd = Dvd.create_record(params.merge!(:owner_id => self.current_user.id))
    if dvd
      flash[:notice] = 'DVD Created Successfully'
    else
      flash[:notice] = 'Invalid Information'
    end

    render :update do |page|
      #page.redirect_to dvd_club_path(params[:dvd_club_id])
      page.redirect_to "/dvds/created/#{dvd.id}"
    end
  end
  
  def created
    # TODO Check if current_user can see this dvd!!!!
    @dvd =  Dvd.find(params[:id])
  end

  def show
    # TODO Check if current_user can see this dvd!!!!
    @dvd_category = DvdCategory.find(params[:dvd_category_id]) rescue nil
    @dvd = Dvd.find(params[:id])  
  end
  
  def index
    @dvds = self.current_user.dvds_by_category(DvdCategory.find(params[:dvd_category_id])) rescue []
  end
  
  # Disponible/Indisponible Story
  def unblock
    @dvd = current_user.owned_dvds.find(params[:id])
    @dvd.unblock!
  end
  
  def block
    @dvd = current_user.owned_dvds.find(params[:id])
    @dvd.block!
  end
  
  # Approve/Refuse Story
  def approve_confirm
    @dvd = current_user.owned_dvds.find(params[:id])
  end
  
  def approve
    @dvd = current_user.owned_dvds.find(params[:id])
    @dvd.register!
    UserMailer.deliver_dvd_approve(@dvd)
    redirect_to "/dvds/approved/#{@dvd.id}"
  end
  
  def approved
    @dvd = current_user.owned_dvds.find(params[:id])  
  end
  
  def refuse_confirm
    @dvd = current_user.owned_dvds.find(params[:id])   
  end
  
  def refuse
    @dvd = current_user.owned_dvds.find(params[:id])
    @dvd.cancel_request!
    UserMailer.deliver_dvd_refuse(@dvd)
    redirect_to "/dvds/refused/#{@dvd.id}"
  end

  def refused
    @dvd = current_user.owned_dvds.find(params[:id])  
  end
  

end
