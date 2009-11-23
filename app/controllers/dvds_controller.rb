class DvdsController < AuthenticatedController
    
  def search
    render :nothing => true and return if params[:title].strip.empty?
    session[:search_titles]  = params[:title].split(/\n/) if params[:title]

    session[:search_current] ||= 0
    @index = session[:search_current]
    @title = session[:search_titles][@index]
    @res = AmazonStore.search("\"#{@title.parameterize}\"", params[:page])
    @total = @res.count

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
    @redirect_url = home_path
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
      (session[:created_ids] ||= []) << dvd.id
      flash[:notice] = %Q{Votre DVD "#{dvd.title}" est bien enregistré} # 'DVD Created Successfully'
    else
      flash[:notice] = %q{Une erreur est survenue lors de l'enregistrement} # 'Invalid Information'
    end
    @index = search_current = session[:search_current] or -1
    @total = search_titles  = ( session[:search_titles] ? session[:search_titles].length : 0 )

    if search_current == search_titles - 1 or dvd
      session[:search_current] = nil
      session[:search_titles]  = nil
      render :update do |page|
        page.redirect_to "/dvds/created/last"
      end
    else
      params[:title] = nil
      session[:search_current] += 1
      
      search
    end
  end
  
  def created
    # TODO Check if current_user can see this dvd!!!!
    @dvds =  Dvd.all(:conditions => {:id => session[:created_ids]})
  end

  def show
    # TODO Check if current_user can see this dvd!!!!
    @dvd_category = DvdCategory.find(params[:dvd_category_id]) rescue nil
    @dvd = Dvd.find(params[:id])  
  end
  
  def index
    @category = DvdCategory.find(params[:dvd_category_id])
    @dvds = self.current_user.dvds_by_category(@category) rescue []
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
    @dvd.update_attribute :booked_at, Time.now
    UserMailer.deliver_dvd_approve(@dvd)
    redirect_to "/dvds/approved/#{@dvd.id}"
  end
  
  def approved
    @dvd          = current_user.owned_dvds.find(params[:id])  
    @redirect_url = mydvds_path
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
    @redirect_url = mydvds_path
  end
  
  def restore
    @dvd = current_user.owned_dvds.find(params[:id])
  end
  
  def restore_confirm
    @dvd = current_user.owned_dvds.find(params[:id])
    @dvd.unregister!
    redirect_to  mydvds_path
  end
end
