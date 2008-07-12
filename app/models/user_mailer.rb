class UserMailer < ActionMailer::Base
  
  def signup_notification(user)
    recipients user.email
    from "noreply@mondvdclub.fr"
    subject "Registration Successful"
    body :body => {:name => user.login}   
  end
  
  def request_password_change(user)
    recipients user.email
    from "noreply@mondvdclub.fr"
    subject "Password Change Confirmation:"
    body :body => {:secret => user.password_secret}       
  end
  
  def club_invitation(dvd_club, mail)
    p dvd_club
    p mail
    mail_recipients = mail['recipients'].split(',')
    recipients mail_recipients
    from "noreply@mondvdclub.fr"
    subject "DVD Club invitation"
    body :body => {:sender => mail[:sender], :dvd_club => dvd_club.name}
  end
  
end