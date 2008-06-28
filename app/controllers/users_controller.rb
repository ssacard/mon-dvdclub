class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    notice = ""
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      @dvd_club = @user.owned_dvd_clubs.new(params[:dvd_club])
      @dvd_club.save
      
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      @user.errors.each_full { |msg| notice += '<li>' + msg + '</li>' }
      @dvd_club.errors.each_full { |msg| notice += '<li>' + msg + '</li>' } if @dvd_club
      flash[:notice] = notice
      render :action => 'new'
    end
  end

end
