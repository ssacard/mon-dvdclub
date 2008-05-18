class DvdsController < ApplicationController

  def search
    session[:search_title] ||= params[:title];
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
      page.redirect_to new_dvd_url
    end
  end

  def index
    @dvds = Dvd.find(:all)
  end
end
