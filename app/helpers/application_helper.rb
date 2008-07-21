# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def button_to_remote(name, options = {}, html_options = nil)
    link_to_remote tag(:input, :type => 'button', :value => name), options, html_options
  end
  
  def avatar(user)
    image_tag user.avatar, :class => :logo
  end
  
  def dvd_cover(dvd)
    image_tag dvd.logo || 'dvd.png',  :class => :logo
  end
  
  def display_flash
    content_tag :div, flash[:notice], :id => 'flash-notice' if flash[:notice] 
  end
  
end
