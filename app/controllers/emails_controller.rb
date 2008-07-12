class EmailsController < ApplicationController
  
  def send_mails
    #if request.post?
      status = UserMailer.deliver_club_invitation(DvdClub.find(params[:dvd_club_id]), params[:mail])       
      if status 
        redirect_to "#{params[:return_url]}/invite?state=done"
      else
        redirect_to "#{params[:return_url]}/invite"
      end
    #end
  end
end
