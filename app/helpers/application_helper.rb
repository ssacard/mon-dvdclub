# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def button_to_remote(name, options = {}, html_options = nil)
    link_to_remote tag(:input, :type => 'button', :value => name), options, html_options
  end
end
