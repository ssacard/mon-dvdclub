class Admin::DvdFormatsController < AdminController
  
  make_resourceful do
    actions :all
    
    response_for :create, :update do |format|
      format.html { redirect_to admin_dvd_formats_path }  
    end
  end
end
