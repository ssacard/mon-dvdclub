class UserMailer < ActionMailer::Base
  
  def signup_notification(user)
    content_type "text/html"
    recipients    user.email
    from          "noreply@mondvdclub.fr"
    subject       "Bienvenu sur MonDVDCub.fr"
    body          :body => {:name => user.login}   
  end
  
  def request_password_change(user, url)
    content_type "text/html"
    recipients    user.email
    from         "noreply@mondvdclub.fr"
    subject      "Demande de changement de mot de passe:"
    body         :body => {:url => url}       
  end
  
  def club_invitation(dvd_club, mail, url)
    url = "http://mondvdclub.fr"+url
    content_type "text/html"
    recipients    mail['recipients'].split(',')
    from          "noreply@mondvdclub.fr"
    subject       "DVD Club invitation"
    body          :body => {:sender => mail[:sender], :message => mail[:message], :dvd_club => dvd_club.name, :url => url}
  end
  
end