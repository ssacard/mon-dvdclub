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

  def create
    if Dvd.create_record(params.merge!(:owner_id => self.current_user.id))
      flash[:notice] = 'DVD Created Successfully'
    else
      flash[:notice] = 'Invalid Information'
    end

    render :update do |page|
      page.redirect_to dvd_club_path(params[:dvd_club_id])
    end
  end

  def show
    @dvd_category = DvdCategory.find(params[:dvd_category_id])
    @dvd = Dvd.find(params[:id])  
  end
  
  def index
    @dvds = self.current_user.dvds_by_category(DvdCategory.find(params[:dvd_category_id])) rescue []
  end
  
  private
  def is_valid
    if params[:dvd_club_id].nil?
      redirect_to '/sessions/new'
    end
  end
end
