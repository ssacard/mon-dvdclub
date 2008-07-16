ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  ## Get error message
  # msg = (instance.error_message.class == Array ? instance.error_message : [instance.error_message])   
  # msg = msg.collect {|m| m.gsub("'", "&#39;")}   
  # msg = msg.join("<br/>")    
  
  msg = instance.error_message
  error_class = "error"
  if html_tag =~ /<(input|textarea|select)[^>]+class=/
    style_attribute = html_tag =~ /class=['"]/
    html_tag.insert(style_attribute + 7, "#{error_class} ")
  elsif html_tag =~ /<(input|textarea|select)/
    first_whitespace = html_tag =~ /\s/
    html_tag[first_whitespace] = " class='#{error_class}' "
  end
  html_tag
  
end    

