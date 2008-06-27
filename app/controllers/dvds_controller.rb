class DvdsController < ApplicationController

  # TODO
  # Use make_resourceful and move these functions in hookup calls
  
  def search
    session[:search_title] = params[:title] if params[:title];
    
    @res = AmazonStore.search(session[:search_title], params[:page])
    render :update do |page|
      page.replace_html 'search-results', :partial => 'search_results'
    end
  end

  def new
  end

  def create
    if Dvd.create_record(params)
      flash[:notice] = 'DVD Created Successfully'
    else
      flash[:notice] = 'Invalid Information'
    end

    render :update do |page|
      page.redirect_to root_url
    end
  end

  def index
    @dvds = Dvd.find(:all)
  end
end
