class Admin::SettingsController < ApplicationController
  
  def index
    @setting = Setting.get
  end
  
  def update
    @setting = Setting.get
    if @setting.update_attributes( params[:setting] )
      redirect_to :action => :index
    else
      render :action => :index
    end
  end
  
end
