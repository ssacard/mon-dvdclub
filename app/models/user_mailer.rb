# -*- coding: utf-8 -*-
class UserMailer < ActionMailer::Base

  def signup_notification(user, home_url)
    content_type "text/html"
    recipients    user.email
    from          "noreply@mondvdclub.fr"
    subject       "Bienvenue sur MonDVDCub.fr"
    body          :body => {:name => user.login, :home_url => home_url}
  end

  def request_password_change(user, url)
    content_type "text/html"
    recipients    user.email
    from         "noreply@mondvdclub.fr"
    subject      "Changement de mot de passe pour MonDVDClub"
    body         :body => {:url => url}
  end

  def club_invitation(dvd_club, mail, url)
    content_type "text/html"
    recipients    mail['recipients'].split(',')
    from          "noreply@mondvdclub.fr"
    subject       "Invitation à partager nos DVDs"
    body          :body => {:sender => mail[:sender], :message => mail[:message], :dvd_club => dvd_club.name, :url => url}
  end


  def dvd_request(dvd, requester, accept_url, refuse_url)
    content_type "text/html"
    recipients    dvd.owner.email
    from          "noreply@mondvdclub.fr"
    subject       "Demande de prêt de DVD"
    body          :body => {:dvd => dvd, :requester => requester, :accept_url => accept_url, :refuse_url => refuse_url}
  end

  def dvd_approve(dvd)
    content_type "text/html"
    recipients    dvd.booked_by_user.email
    from          "noreply@mondvdclub.fr"
    subject       "Confirmation de prêt de DVD"
    body          :body => {:dvd => dvd, :requester => dvd.booked_by_user}
  end

  def dvd_refuse(dvd)
    content_type "text/html"
    recipients    dvd.booked_by_user.email
    from          "noreply@mondvdclub.fr"
    subject       "Confirmation de prêt de DVD"
    body          :body => {:dvd => dvd, :requester => dvd.booked_by_user}
  end
  
  def dvd_return(dvd)
    content_type "text/html"
    recipients dvd.owner.email
    from "noreply@mondvdclub.fr"
    subject "Demande de restitution de DVD"
    body :body => { :dvd => dvd }
  end
      

  def protect_against_forgery?
    false
  end

end
