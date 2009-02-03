ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  # Get error message
  msg = (instance.error_message.class == Array ? instance.error_message : [instance.error_message])   
  msg = msg.collect {|m| m.gsub("'", "&#39;")}   
  msg = msg.join(" et ")    
  error_class = "error"
  unless html_tag =~ /hidden/
    if html_tag =~ /checkbox/
      html_tag += "<span class='error_info'> (#{msg}) </span>"
    elsif html_tag =~ /<(input|textarea|select)[^>]+class=/
      style_attribute = html_tag =~ /class=['"]/
      html_tag.insert(style_attribute + 7, "#{error_class} ")
    elsif html_tag =~ /<(input|textarea|select)/
      first_whitespace = html_tag =~ /\s/
      html_tag[first_whitespace] = " class='#{error_class}' "
    end
    html_tag += '<br/>' + "<div class='error_info'> #{msg} </div>" unless  html_tag =~ /checkbox/
  end
  html_tag
end    

# ActiveRecord::Errors.default_error_messages = {
#   :inclusion => "pas inclus dans la liste",
#   :exclusion => "mot réservé",
#   :invalid => "invalide",
#   :confirmation => "n'est pas égale à la confirmation",
#   :accepted  => "doit être accepter",
#   :empty => "champ obligatoire",
#   :blank => "champ obligatoire",
#   :too_long => "trop long (maximum %d caractères)",
#   :too_short => "trop court (minimum %d caractères)",
#   :wrong_length => "taille incorrecte (doit être de %d caractères)",
#   :taken => "déja pris",
#   :not_a_number => "n'est pas un nombre",
#   :greater_than => "doit être plus grand que %d",
#   :greater_than_or_equal_to => "doit être plus grand ou égal à %d",
#   :equal_to => "doit être plus égale à %d",
#   :less_than => "doit être plus petit que %d",
#   :less_than_or_equal_to => "doit être plus petit ou égal à %d",
#   :odd => "doit être impair",
#   :even => "doit être pair"
# }
