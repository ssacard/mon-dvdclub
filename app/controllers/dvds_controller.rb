class DvdsController < ApplicationController

  def search
    @res = AmazonStore.search(params[:title])
    render :update do |page|
      page.replace_html 'search-results', :partial => 'search_results'
    end
  end

  def new
  end

  def create
    Dvd.create_record(params)
    flash[:notice] = "DVD Created Successfully"
    render :update do |page|
      page.redirect_to '/dvds/new'
    end
  end

  def index
    @dvds = Dvd.find(:all)
  end
end
