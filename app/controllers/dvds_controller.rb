class DvdsController < AuthenticatedController
  before_filter :is_valid, :only => [:index, :new]
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
    @dvd =  Dvd.find(params[:id])
  end

  def show
    @dvd_category = DvdCategory.find(params[:dvd_category_id]) rescue nil
    @dvd = Dvd.find(params[:id])  
  end
  
  def index
    @dvds = self.current_user.dvds_by_category(DvdCategory.find(params[:dvd_category_id])) rescue []
  end
  
  def details
    @dvd = Dvd.find(params[:id])  
  end
  
  # Disponible/Indisponible Story
  
  def make_available
    @dvd = Dvd.find(params[:id])
    @dvd.unregister!
      render :update do |page|
        page.redirect_to "/dvds/available_confirmation/#{@dvd.id}"
      end
  end
  
  def available_confirmation
    @dvd = Dvd.find(params[:id]) 
  end
  
  def book_confirmation
    @dvd = Dvd.find(params[:id])
  end
  
  def book
    @dvd = Dvd.find(params[:id])
    @dvd.book!
    render :update do |page|
      page.redirect_to "/dvds/book_confirmation/#{@dvd.id}"
    end
  end
  
  # Approve/Refuse Story
  
  def approve_confirm
    @dvd = Dvd.find(params[:id])
  end
  
  def approve
    @dvd = Dvd.find(params[:id])
    @dvd.register!
    render :update do |page|
      page.redirect_to "/dvds/approved/#{@dvd.id}"
    end
  end
  
  def approved
    @dvd = Dvd.find(params[:id])  
  end
  
  def refuse_confirm
    @dvd = Dvd.find(params[:id])   
  end
  
  def refuse
    @dvd = Dvd.find(params[:id])
    @dvd.cancel_request!
    render :update do |page|
      page.redirect_to "/dvds/refused/#{@dvd.id}"
    end
  end

  def refused
    @dvd = Dvd.find(params[:id])  
  end
  
  # ajax redirection
  
  def redirect_to_home
    render :update do |page|
      page.redirect_to "/home/dvds"
    end
  end
  
  private
  def is_valid
    if params[:dvd_club_id].nil? && params[:dvd_category_id].nil?
      redirect_to '/sessions/new'
    end
  end
  

end
