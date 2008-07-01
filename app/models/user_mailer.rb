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
end