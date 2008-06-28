class Admin::ClubTopicsController < AdminController
  
  make_resourceful do
    actions :all
    
    response_for :create, :update do |format|
      format.html { redirect_to admin_club_topics_path }  
    end
  end
end
